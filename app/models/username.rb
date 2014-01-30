class Username < ActiveRecord::Base
  extend ActiveSupport::Inflector # need transliterate @ class level

  UNICODE_WORDS_PATTERN = /\p{Word}+/

  self.table_name = 'conciage.username'

  belongs_to :user, foreign_key: "user_id"
  belongs_to :business_profile, foreign_key: "places_id"

  def self.build_new_with_omniauth(data)
    return unless data
    new(username: username_from_omniauth(data))
  end

  private

  def self.username_from_omniauth(data)
    nick = data.info.nickname.to_s.strip
    return nick unless nick.empty?

    names = data.info.name.to_s.strip.scan(UNICODE_WORDS_PATTERN)
    first_name = transliterate(names.first.downcase)
    last_name = transliterate(names[1..-1].last.to_s.downcase)

    last_name.empty? ? first_name : "#{first_name.slice(0).to_s}#{last_name}"
  end
end