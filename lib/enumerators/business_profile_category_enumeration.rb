module BusinessProfileCategoryEnumeration
  extend Enumerize

  enumerize :category_type, in: {primary: 1, secondary: 2, tertiary: 3}, predicates: true
end