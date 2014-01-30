module GenderEnumeration
  #extend Enumerize
  #enumerize :gender, in: {female: 'f', male: 'm'}, predicates: true

  module ClassMethods
    def gender_options
      [["I'm a girl", "f"], ["I'm a boy", "m"]]
    end
  end

  def self.included(base)
    base.extend(Enumerize)
    base.extend(ClassMethods)
    base.enumerize :gender, in: {female: 'f', male: 'm'}, predicates: true
  end
end