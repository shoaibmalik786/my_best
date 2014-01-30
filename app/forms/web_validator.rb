class WebValidator < ActiveModel::EachValidator
 def validate_each(record, attribute, value)
   record.errors.add attribute, (options[:message] || "is invalid") unless value =~ /\A((https?:\/\/)?[\w\.]+\.[a-z,\/]{2,}|)\Z/i
 end
end