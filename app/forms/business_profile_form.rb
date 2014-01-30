require 'reform/form/coercion'

class BusinessProfileForm < Reform::Form
  include Reform::Form::Coercion
  include Reform::Form::ActiveRecord

  model :business_profile

  property :name, type: String
  validates :name, presence: true, length: { maximum: 50 }

  property :username do
    include Reform::Form::Coercion
    include Reform::Form::ActiveRecord

    property :username, type: String
    validates :username, username: true
    validates_uniqueness_of :username
  end

  # needed for new category template
  def empty_business_profile_category
    model.business_profile_categories.build
  end

  collection :business_profile_categories do
    property :places_category_name, getter: ->(data) { BusinessCategory.find_by_id(places_category_id).try(:name) }
    property :places_category_id
    property :places_id
    property :id, getter: ->(data) { places_id }
    validates :places_category_id, business_category: true
  end

  property :contact, type: String
  validates :contact, length: { maximum: 255 }

  property :address_one, type: String
  validates :address_one, length: { maximum: 255 }

  property :address_two, type: String
  validates :address_two, length: { maximum: 255 }

  property :country_name, getter: ->(data) { Country.find_by_id(country_id).try(:name) }
  property :country_code, getter: ->(data) { Country.find_by_id(country_id).try(:code) }
  property :country_id
  validates :country_id, country: true

  property :state_name, getter: ->(data) { State.find_by_id(state_id).try(:name) }
  property :state_id
  validates :state_id, state: true

  property :city_name, getter: ->(data) { City.find_by_id(city_id).try(:name) }
  property :city_id
  validates :city_id, city: true

  property :zip_code_name, getter: ->(data) { ZipCode.find_by_id(zip_code_id).try(:name) }
  property :zip_code_id
  validates :zip_code_id, zip_code: true

  property :time_zone_name, getter: ->(data) { TimeZone.find_by_code(time_zone).try(:name) }
  property :time_zone
  validates :time_zone, time_zone: true

  property :bio, type: String
  validates :bio, length: { maximum: 160 }

  property :email, type: String
  validates :email, email: true

  property :phone, type: String
  validates :phone, phony_plausible: true

  property :web, type: String
  validates :web, web: true

  property :isfacebookpersonal
  property :business_profile_facebook do
    include Reform::Form::Coercion
    include Reform::Form::ActiveRecord

    property :uid, type: String
    validates_uniqueness_of :uid
    property :enabled
    property :web, type: String
    validates :web, web: true
    property :image, type: String
    property :profile, type: String
    property :gender, type: String
    property :birthday, type: String
    property :locale, type: String
    property :location, type: String
    property :time_zone, type: String
  end
  
  property :isgooglepluspersonal
  property :business_profile_google do
    include Reform::Form::Coercion
    include Reform::Form::ActiveRecord

    property :uid, type: String
    validates_uniqueness_of :uid
    property :enabled
    property :web, type: String
    validates :web, web: true
    property :image, type: String
    property :profile, type: String
    property :gender, type: String
    property :birthday, type: String
    property :locale, type: String
  end
  
  property :istwitterpersonal
  property :business_profile_twitter do
    include Reform::Form::Coercion
    include Reform::Form::ActiveRecord

    property :uid, type: String
    validates_uniqueness_of :uid
    property :enabled
    property :web, type: String
    validates :web, web: true
    property :image, type: String
    property :location, type: String
    property :geo_enabled
    property :time_zone, type: String
    property :utc_offset, type: String
  end
end