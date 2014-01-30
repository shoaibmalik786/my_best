require 'reform/form/coercion'

class UserProfileForm < Reform::Form
  include Reform::Form::Coercion
  include Reform::Form::ActiveRecord

  model :user

  property :avatar

  property :username do
    include Reform::Form::Coercion
    include Reform::Form::ActiveRecord

    property :username, type: String
    validates :username, username: true
    validates_uniqueness_of :username
  end

  property :first_name, type: String
  validates :first_name, presence: true, length: { maximum: 50 }

  property :last_name, type: String
  validates :last_name, length: { maximum: 50 }

  property :email, type: String
  validates :email, presence: true, email: true
  validates_uniqueness_of :email

  property :gender
  include GenderEnumeration

  property :date_of_birth, type: DateTime

  property :time_zone_name, getter: ->(data) { TimeZone.find_by_code(time_zone).try(:name) }
  property :time_zone
  validates :time_zone, time_zone:true

  property :bio, type: String
  validates :bio, length: { maximum: 150 }

  property :web, type: String
  validates :web, web: true

  #property :user_address do
    #include Reform::Form::Coercion

    #property :address_one, type: String
    #validates :address_one, length: { maximum: 255 }

    #property :address_two, type: String
    #validates :address_two, length: { maximum: 255 }

    #property :country_name, getter: ->(data) { Country.find_by_id(country_id).try(:name) }
    #property :country_code, getter: ->(data) { Country.find_by_id(country_id).try(:code) }
    #property :country_id
    #validates :country_id, country: true

    #property :state_name, getter: ->(data) { State.find_by_id(state_id).try(:name) }
    #property :state_id
    #validates :state_id, state: true

    #property :city_name, getter: ->(data) { City.find_by_id(city_id).try(:name) }
    #property :city_id
    #validates :city_id, city: true

    #property :zip_code_name, getter: ->(data) { ZipCode.find_by_id(zip_code_id).try(:name) }
    #property :zip_code_id
    #validates :zip_code_id, zip_code: true
  #end
end
