class UserAddress < ActiveRecord::Base
  self.table_name = 'conciage.user_address'
  self.primary_key = 'address_id'

  alias_attribute :zip_code_id, :zipcode_id

  belongs_to :user
  belongs_to :country
  belongs_to :state
  belongs_to :city
  belongs_to :zip_code, foreign_key: 'zipcode_id'
end
