# https://github.com/plataformatec/devise/wiki/How-To:-Display-a-custom-sign_in-form-anywhere-in-your-app
# original DeviseHelper contains only #devise_error_messages! which is reimplemented, so it is OK to name it the same
module DeviseHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def devise_error_messages!
    return if resource.errors.empty?

    resource.errors.full_messages.map do |message|
      render(partial: "layouts/alert", locals: {level: :error, message: message}).to_s
    end.join.html_safe
  end
end
