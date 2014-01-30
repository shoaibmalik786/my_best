class AuthorizeUser
  include Wisper::Publisher

  attr_reader :user_info_factory, :user_mapper

  def initialize(user_info_factory, user_mapper = UserMapper)
    @user_info_factory = user_info_factory
    @user_mapper = user_mapper
  end

  def with(omniauth_data)
    if user_info = user_info_factory.find_by(uid: omniauth_data.uid)
      broadcast(:user_authorized_successfully, user_info.user)
    else
      email = omniauth_data.info.email
      if email && user = User.find_by_email(email)
        append_user_info(user, omniauth_data)
      else
        user = build_new_user(omniauth_data)
      end

      if user_mapper.new.save(user)
        broadcast(:user_authorized_successfully, user)
      else
        broadcast(:user_authorization_failed, user)
      end
    end
  end

  private

  def append_user_info(user, omniauth_data)
    user_info_factory.build_new_with_omniauth(omniauth_data).tap do |user_info|
      # http://www.davidverhasselt.com/2011/06/28/5-ways-to-set-attributes-in-activerecord/
      user.send("#{user_info_factory.name.underscore}=", user_info)
    end
  end

  def build_new_user(omniauth_data)
    User.build_new_with_omniauth(omniauth_data).tap do |user|
      append_user_info(user, omniauth_data)
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
      user.username = Username.build_new_with_omniauth(omniauth_data)
    end
  end
end
