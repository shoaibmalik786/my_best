# https://github.com/zquestz/omniauth-google-oauth2

class GoogleUserInfo < ActiveRecord::Base
  self.table_name = 'conciage.user_info_google'

  belongs_to :user

  def self.build_new_with_omniauth(data)
    return unless data

    new(
        uid: data.uid,
        image: data.info.image,
        profile: data.extra.raw_info.link,
        gender: data.extra.raw_info.gender,
        birthday: data.extra.raw_info.birthday,
        locale: data.extra.raw_info.locale
    )
  end
end
