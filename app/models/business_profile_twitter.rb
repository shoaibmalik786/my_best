class BusinessProfileTwitter < ActiveRecord::Base
  self.table_name = 'conciage.places_profile_twitter'

  belongs_to :business_profile, foreign_key: 'place_id'
end