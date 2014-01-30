class CityMapper
  attr_reader :logger

  def initialize(logger = Rails.logger)
    @logger = logger
  end

  def find_by_name(name, additional_criteria = {})
    return nil unless name
    search(additional_criteria.merge({name: name})).first
  end

  def search(params)
    cities = find_in_database(params)
    cities.empty? ? find_in_factual(params) : cities
  end

  private

  def find_in_factual(params)
    return [] unless params_valid?(params)

    cities = FactualService.new.find_cities(params[:name], params[:country_code])
    return [] if cities.empty?

    existing = City.where("factual_id in (?)", cities.map(&:factual_id)).pluck(:factual_id).to_a
    cities.reject { |city| existing.include?(city.factual_id) }.each do |city|
      country = Country.where(code: city.country.code).first
      city.country = country
      city.save
      city.reload
    end

    City.where("factual_id in (?)", cities.map(&:factual_id)).to_a
  end

  def find_in_database(params)
    return [] unless params_valid?(params)

    conditions = []
    data = {}

    if params[:name]
      conditions << "lower(city.name) like :name"
      data[:name] = "%#{params[:name].downcase}%"
    end

    if params[:country_code]
      conditions << "lower(code) = :country_code"
      data[:country_code] = params[:country_code].downcase
    end

    City.includes(:country).references(:country).where(conditions.join(" AND "), data).to_a
  end

  def params_valid?(params)
    !params.select { |key, value| %w{name country_code}.include?(key.to_s) }.values.map(&:to_s).join("").empty?
  end
end