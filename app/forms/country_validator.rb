class CountryValidator < ActiveModel::EachValidator
  attr_reader :country_finder

  def initialize(options, country_finder = Country)
    super(options)
    @country_finder = country_finder
  end

  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "is invalid, use autocomplete to select") unless value.to_s.empty? || country_finder.find_by_id(value)
  end
end
