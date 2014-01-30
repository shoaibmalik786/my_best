# http://natashatherobot.com/devise-rails-sign-in/
# http://jessehowarth.com/devise
class Users::SessionsController < Devise::SessionsController
  def create
    respond_to do |format|
      format.json {
        resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        sign_in_and_redirect(resource_name, resource)
      }
      format.html do
        resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        SessionsHistory.create(ip: request.ip, header: request.user_agent, user_id: resource.id)
        super
      end
    end
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    render :json => {:success => true, :redirect => stored_location_for(scope) || after_sign_in_path_for(resource)}
  end

  def failure
    failure_alert = render_to_string(partial: "layouts/alert", locals: {level: :error, message: I18n.t('devise.failure.invalid')})
    render json: {success: false, alerts: [failure_alert]}
  end
end
