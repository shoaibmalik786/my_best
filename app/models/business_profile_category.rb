class BusinessProfileCategory < ActiveRecord::Base
  self.table_name = 'conciage.places_profile_categories'

  belongs_to :business_profile, foreign_key: 'places_id'
  belongs_to :business_category, foreign_key: 'places_category_id'

  include BusinessProfileCategoryEnumeration
end
