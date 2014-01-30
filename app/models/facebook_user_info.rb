# https://github.com/mkdynamic/omniauth-facebook
# https://developers.facebook.com/docs/reference/api/user/

class FacebookUserInfo < ActiveRecord::Base
  self.table_name = 'conciage.user_info_facebook'

  belongs_to :user

  def self.build_new_with_omniauth(data)
    return unless data

    new(
        uid: data.uid,
        image: data.info.image,
        profile: data.extra.raw_info.link,
        gender: data.extra.raw_info.gender,
        birthday: data.extra.raw_info.birthday,
        locale: data.extra.raw_info.locale,
        location: data.info.location,
        time_zone: data.extra.raw_info.time_zone
    )
  end
end
