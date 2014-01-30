# https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
class Users::RegistrationsController < Devise::RegistrationsController
  def with
    @user = User.find(current_user.id)
    if @user.email_authenticated?
      super # use default behaviour, require current password for all user changes
    else
      update_without_password
    end
  end

  # direct copy of original, just changed to use update_resource_without_password
  # /home/elvanja/.rbenv/versions/2.0.0-p247/lib/ruby/gems/2.0.0/gems/devise-3.1.0/app/controllers/devise/registrations_controller.rb:39
  def update_without_password
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if update_resource_without_password(resource, account_update_params)
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ? :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  def update_resource_without_password(resource, params)
    params.delete(:current_password) # don't require current password for updates
    result = resource.update_without_password(params) # don't update passwords either, don't need them
    resource.send_reconfirmation_instructions if result && resource.pending_reconfirmation? # confirm email if changed
    result
  end
end