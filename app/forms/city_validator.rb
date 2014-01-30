class CityValidator < ActiveModel::EachValidator
  attr_reader :city_finder

  def initialize(options, city_finder = City)
    super(options)
    @city_finder = city_finder
  end

  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "is invalid, use autocomplete to select") unless value.to_s.empty? || city_finder.find_by_id(value)
  end
end
