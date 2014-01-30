class UserProfilesController < ApplicationController
  before_filter :create_edit_form

  def edit
  end

  def update
    update = UpdateUserProfile.new(@form).tap do |action|
      action.on(:user_profile_updated_successfully) do
        flash[:notice] = "Successfully updated the profile."
        redirect_to current_user_profile_edit_path
      end
      action.on(:user_profile_update_failed) {render :edit}
    end
    update.with(params[:user_profile])
  end

  def profile_page
  end

  private

  def user
    @user = current_user.tap do |user|
      user.build_username unless user.username
    end
  end
  helper_method :user

  def create_edit_form
    @form = UserProfileForm.new(user)
  end
end
