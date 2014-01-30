class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale

  helper FlashHelper
  helper DeviseHelper

  protected

  # https://github.com/plataformatec/devise#strong-parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit! }
  end

  # http://guides.rubyonrails.org/i18n.html
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
