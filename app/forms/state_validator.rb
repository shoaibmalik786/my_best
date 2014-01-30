class StateValidator < ActiveModel::EachValidator
  attr_reader :state_finder

  def initialize(options, state_finder = State)
    super(options)
    @state_finder = state_finder
  end

  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "is invalid, use autocomplete to select") unless value.to_s.empty? || state_finder.find_by_id(value)
  end
end
