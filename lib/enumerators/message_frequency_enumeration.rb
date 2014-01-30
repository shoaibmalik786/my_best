module MessageFrequencyEnumeration
  extend Enumerize

  enumerize :frequency, in: {daily: "d", weekly: "w", monthly: "m"}, predicates: true
end