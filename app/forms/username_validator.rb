class UsernameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # remove attribute from errors since we're using a join model for usernames
    if value.to_s.empty?
      # TODO can there be better things than " " ?
      record.errors.add " ", (options[:message] || "can't be blank")
    else
      record.errors.add " ", (options[:message] || "can't use reserved names") if %w(admin administrator superuser).include?(value.to_s)
      record.errors.add " ", (options[:message] || "can use only letters and numbers") unless value =~ /\A[a-z_0-9]+\Z/i
    end
  end
end
