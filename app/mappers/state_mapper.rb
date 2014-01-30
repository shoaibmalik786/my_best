class StateMapper
  attr_reader :logger

  def initialize(logger = Rails.logger)
    @logger = logger
  end

  def find_by_name(name, additional_criteria = {})
    return nil unless name
    search(additional_criteria.merge({name: name})).first
  end

  def search(params)
    states = find_in_database(params)
    states.empty? ? find_in_factual(params) : states
  end

  private

  def find_in_factual(params)
    return [] unless params_valid?(params)

    states = FactualService.new.find_states(params[:name], params[:country_code])
    return [] if states.empty?

    existing = State.where("factual_id in (?)", states.map(&:factual_id)).pluck(:factual_id).to_a
    states.reject { |state| existing.include?(state.factual_id) }.each do |state|
      country = Country.where(code: state.country.code).first
      state.country = country
      state.save
    end

    State.where("factual_id in (?)", states.map(&:factual_id)).to_a
  end

  def find_in_database(params)
    return [] unless params_valid?(params)

    conditions = []
    data = {}

    if params[:name]
      conditions << "lower(state.name) like :name"
      data[:name] = "%#{params[:name].downcase}%"
    end

    if params[:country_code]
      conditions << "lower(code) = :country_code"
      data[:country_code] = params[:country_code].downcase
    end

    State.includes(:country).references(:country).where(conditions.join(" AND "), data).to_a
  end

  def params_valid?(params)
    !params.select { |key, value| %w{name country_code}.include?(key.to_s) }.values.map(&:to_s).join("").empty?
  end
end