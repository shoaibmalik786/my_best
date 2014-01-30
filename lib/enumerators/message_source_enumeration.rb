module MessageSourceEnumeration
  extend Enumerize

  enumerize :message_source_id, in: {user: 1, api: 2, crawler: 3}, predicates: true
end