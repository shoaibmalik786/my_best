class ZipCodeMapper
  attr_reader :logger

  def initialize(logger = Rails.logger)
    @logger = logger
  end

  def find_by_name(name, additional_criteria = {})
    return nil unless name
    search(additional_criteria.merge({name: name})).first
  end

  def search(params)
    zip_codes = find_in_database(params)
    zip_codes.empty? ? find_in_factual(params) : zip_codes
  end

  private

  def find_in_factual(params)
    return [] unless params_valid?(params)

    zip_codes = FactualService.new.find_zip_codes(params[:name], params[:country_code])
    return [] if zip_codes.empty?

    existing = ZipCode.where("factual_id in (?)", zip_codes.map(&:factual_id)).pluck(:factual_id).to_a
    zip_codes.reject { |zip_code| existing.include?(zip_code.factual_id) }.each do |zip_code|
      country = Country.where(code: zip_code.country.code).first
      zip_code.country = country
      zip_code.save
    end

    ZipCode.where("factual_id in (?)", zip_codes.map(&:factual_id)).to_a
  end

  def find_in_database(params)
    return [] unless params_valid?(params)

    conditions = []
    data = {}

    if params[:name]
      conditions << "lower(zip_code.name) like :name"
      data[:name] = "%#{params[:name].downcase}%"
    end

    if params[:country_code]
      conditions << "lower(code) = :country_code"
      data[:country_code] = params[:country_code].downcase
    end

    ZipCode.includes(:country).references(:country).where(conditions.join(" AND "), data).to_a
  end

  def params_valid?(params)
    !params.select { |key, value| %w{name country_code}.include?(key.to_s) }.values.map(&:to_s).join("").empty?
  end
end