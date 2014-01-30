class BusinessCategoryValidator < ActiveModel::EachValidator
  attr_reader :category_finder

  def initialize(options, category_finder = BusinessCategory)
    super(options)
    @category_finder = category_finder
  end

  def validate_each(record, attribute, value)
    if value.to_s.empty?
      # could be solved with ```presence: true``` but is important to the domain, so is left here
      record.errors.add attribute, (options[:message] || "can't be blank")
    else
      record.errors.add attribute, (options[:message] || "is invalid, use autocomplete to select") unless category_finder.find_by_id(value)
    end
  end
end
