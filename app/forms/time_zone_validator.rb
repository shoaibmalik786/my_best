class TimeZoneValidator < ActiveModel::EachValidator
  attr_reader :time_zone_finder

  def initialize(options, time_zone_finder = TimeZone)
    super(options)
    @time_zone_finder = time_zone_finder
  end

  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "is invalid, use autocomplete to select") unless value.to_s.empty? || time_zone_finder.find_by_code(value)
  end
end
