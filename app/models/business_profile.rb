class BusinessProfile < ActiveRecord::Base
  self.table_name = 'conciage.places_profile'
  self.primary_key = 'places_id'

  alias_attribute :id, :places_id
  alias_attribute :zip_code_id, :zip_id
  alias_attribute :phone, :tel
  alias_attribute :web, :website

  belongs_to :user
  belongs_to :place, foreign_key: 'places_id'
  has_one :username, dependent: :destroy, foreign_key: 'places_id'
  has_one :business_profile_facebook, -> { order 'uid' }, dependent: :destroy, foreign_key: 'places_id'
  has_one :business_profile_google, -> { order 'uid' }, dependent: :destroy, foreign_key: 'place_id'
  has_one :business_profile_twitter, -> { order 'uid' }, dependent: :destroy, foreign_key: 'place_id'
  has_many :business_profile_categories, -> { order 'category_type' }, dependent: :destroy, foreign_key: 'places_id'
  has_many :business_categories, through: :business_profile_categories
  has_many :messages, foreign_key: 'profile_places_id', dependent: :destroy
           belongs_to :country
  belongs_to :state
  belongs_to :city
  belongs_to :zip_code, foreign_key: 'zip_id'

  def primary_business_category
    business_profile_categories.find { |relation| relation.category_type && relation.category_type.primary? }.try(:business_category)
  end
end
