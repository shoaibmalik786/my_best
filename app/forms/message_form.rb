require 'reform/form/coercion'

class MessageForm < Reform::Form
  include Reform::Form::Coercion
  include Reform::Form::ActiveRecord

  model :message

  property :business_profile_id
  validates :business_profile_id, business_profile: true

  property :message_type
  include MessageTypeEnumeration

  property :description, type: String
  validates :description, presence: true, length: { maximum: 250 }

  property :start_date, type: Date

  property :end_date, type: Date

  property :frequency
  include MessageFrequencyEnumeration

  property :frequency_time, type: Time

  property :place do
    property :place_id
    property :factual_id
    property :name
    validates_presence_of :name
    property :address
    property :region
    property :locality
    property :address_extended
    property :postcode
    property :country
    property :neighbourhood
    property :tel
    property :fax
    property :website
    property :longitude
    property :latitude
    property :post_town
    property :chain_id
    property :chain_name
    property :admin_region
    property :po_box
    property :category_ids
    property :category_labels
    property :email
  end
end
