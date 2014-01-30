class BusinessProfileValidator < ActiveModel::EachValidator
  attr_reader :business_profile_finder

  def initialize(options, business_profile_finder = BusinessProfile)
    super(options)
    @business_profile_finder = business_profile_finder
  end

  def validate_each(record, attribute, value)
    if value.to_s.empty?
      # could be solved with ```presence: true``` but is important to the domain, so is left here
      record.errors.add attribute, (options[:message] || "can't be blank")
    else
      record.errors.add attribute, (options[:message] || "is invalid, choose one of your businesses") unless business_profile_finder.find_by_id(value)
    end
  end
end
