# https://github.com/arunagw/omniauth-twitter

class TwitterUserInfo < ActiveRecord::Base
  self.table_name = 'conciage.user_info_twitter'

  belongs_to :user

  def self.build_new_with_omniauth(data)
    return unless data

    new(
        uid: data.uid,
        image: data.info.image,
        location: data.info.location,
        geo_enabled: data.extra.raw_info.geo_enabled,
        time_zone: data.extra.raw_info.time_zone,
        utc_offset: data.extra.raw_info.utc_offset
    )
  end
end
