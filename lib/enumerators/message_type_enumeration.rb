module MessageTypeEnumeration
  extend Enumerize

  enumerize :message_type, in: {social_incentive: "S", money_saving: "M"}, default: :social_incentive, predicates: true
end