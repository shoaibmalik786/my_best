# https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
# https://gist.github.com/schleg/993566
# https://github.com/CanCeylan/can-auth
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_user!

  def twitter
    authorize('Twitter', TwitterUserInfo)
  end

  def google_oauth2
    authorize('Google', GoogleUserInfo)
  end

  def facebook
    authorize('Facebook', FacebookUserInfo)
  end

  private

  def authorize(provider, user_info_factory)
    omniauth_data = request.env['omniauth.auth']
    authorize = AuthorizeUser.new(user_info_factory).tap do |action|
      action.on(:user_authorized_successfully) do |user|
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider)
        sign_in_and_redirect(user)
      end
      action.on(:user_authorization_failed) do |user|
        session[:omniauth] = omniauth_data.except('extra')
        flash[:error] = I18n.t('devise.omniauth_callbacks.failure', kind: provider, reason: user.errors.full_messages.join(', '))
        redirect_to new_user_registration_path
      end
    end
    authorize.with(omniauth_data)
  end
end
