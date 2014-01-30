module MessageStatusEnumeration
  extend Enumerize

  enumerize :message_status_id, in: {saved: 1, paused: 2, running: 3, stopped: 4}, predicates: true
end