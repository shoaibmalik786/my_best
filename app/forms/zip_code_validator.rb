class ZipCodeValidator < ActiveModel::EachValidator
  attr_reader :zip_code_finder

  def initialize(options, zip_code_finder = ZipCode)
    super(options)
    @zip_code_finder = zip_code_finder
  end

  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "is invalid, use autocomplete to select") unless value.to_s.empty? || zip_code_finder.find_by_id(value)
  end
end
