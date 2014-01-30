class TimeZone
  attr_reader :code, :name

  def initialize(code, name)
    @code = code
    @name = name
  end

  def self.all
    ActiveSupport::TimeZone.all.map { |zone| TimeZone.new(zone.tzinfo.identifier, zone.to_s) }
  end

  def self.find_by_code(code)
    return unless code
    all.find { |zone| zone.code.downcase == code.downcase }
  end

  def self.search_by_name(name)
    return unless name
    all.select { |zone| zone.name.downcase.include?(name.downcase) }
  end
end