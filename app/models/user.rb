class User < ActiveRecord::Base
  UNICODE_WORDS_PATTERN = /\p{Word}+/

  self.table_name = 'conciage.user_info'
  self.primary_key = 'user_id'

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :confirmable, :trackable, :omniauthable, :validatable, :token_authenticatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/missing_avatar.jpg"

  before_save :ensure_authentication_token

  has_one :twitter_user_info, dependent: :destroy, foreign_key: "user_id"
  has_one :google_user_info, dependent: :destroy, foreign_key: "user_id"
  has_one :facebook_user_info, dependent: :destroy, foreign_key: "user_id"

  has_many :user_addresses, dependent: :destroy
  has_one :username, dependent: :destroy, foreign_key: "user_id"
  has_many :business_profiles

  has_many :owned_messages, -> { order "created_datetime desc" }, source: :messages, through: :business_profiles, class_name: 'Message'
  has_many :authored_messages, -> { order "created_datetime desc" }, foreign_key: "user_id", class_name: 'Message'

  include GenderEnumeration

  def title
    name.blank? ? email : name
  end

  def short_title
    first_name.blank? ? email.split("@").first.titleize : first_name
  end

  def has_business_profiles?
    business_profiles.size > 0
  end

  def email_authenticated?
    omniauth_authentications.empty?
  end

  # devise schema merging workaround
  def name
    "#{first_name} #{last_name}".strip
  end

  # devise validatable workaround for omniauthable
  def password_required?
    (email_authenticated? || !password.blank?) && super
  end

  # devise validatable workaround for omniauthable
  def email_required?
    (email_authenticated? || !email.blank?) && super
  end

  def self.build_new_with_omniauth(data)
    return unless data

    new(
        email: data.info.email,
        first_name: self.first_name_from_omniauth(data),
        last_name: self.last_name_from_omniauth(data)
    )
  end

  private

  def omniauth_authentications
    [twitter_user_info, google_user_info, facebook_user_info] - [nil]
  end

  def self.first_name_from_omniauth(data)
    first_name = data.info.first_name.to_s.strip
    first_name.empty? ? split_name(data).first : first_name
  end

  def self.last_name_from_omniauth(data)
    last_name = data.info.last_name.to_s.strip
    last_name.empty? ? split_name(data).last : last_name
  end

  def self.split_name(data)
    names = data.info.name.to_s.strip.scan(UNICODE_WORDS_PATTERN)
    first_name = names.first
    last_name = names[1..-1].join(' ')
    return first_name, last_name
  end
end
