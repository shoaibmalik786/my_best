class BusinessProfileFacebook < ActiveRecord::Base
  self.table_name = 'conciage.places_profile_facebook'

  belongs_to :business_profile, foreign_key: 'places_id'
end