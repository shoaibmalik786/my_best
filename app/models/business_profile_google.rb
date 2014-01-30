class BusinessProfileGoogle < ActiveRecord::Base
  self.table_name = 'conciage.places_profile_google'

  belongs_to :business_profile, foreign_key: 'place_id'
end