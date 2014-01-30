module MessageActionEnumeration
  extend Enumerize

  enumerize :action_button_id, in: {purchase: 1, rsvp: 2, donate: 3, claim: 4}, predicates: true
end