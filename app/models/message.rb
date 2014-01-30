class Message < ActiveRecord::Base
  self.table_name = 'conciage.message'
  self.primary_key = 'message_id'

  alias_attribute :business_profile_id, :profile_places_id
  alias_attribute :latitude, :lattitude

  scope :drafts, -> { where(published: false) }

  belongs_to :business_profile, foreign_key: 'profile_places_id'
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :place, foreign_key: 'places_id_execution'

  include MessageTypeEnumeration
  include MessageFrequencyEnumeration
  include MessageStatusEnumeration
  include MessageSourceEnumeration
  include MessageActionEnumeration

  delegate :full_address, to: :place

  def title
    description.scan(/\w+/).take(5).join(" ").titleize + " ..."
  end
end
