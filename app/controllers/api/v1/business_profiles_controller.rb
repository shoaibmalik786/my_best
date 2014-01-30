class Api::V1::BusinessProfilesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter  :verify_authenticity_token

  respond_to :json

  def index
    @business_profiles = current_user.business_profiles
    respond_with(@business_profiles)
  end

  def create
    @business_profile = current_user.business_profiles.new(business_profile_params)
    if @business_profile.save
      render json: @business_profile
    else
      render json: {errors: @business_profile.errors, status: :unprocessable_entity}
    end
  end

  def update
    update = UpdateBusinessProfile.new(current_user, @form).tap do |action|
      action.on(:business_profile_updated_successfully) do |business_profile|
        flash[:notice] = "Successfully updated the business profile."
        redirect_to edit_business_profile_path(business_profile)
      end
      action.on(:business_profile_update_failed) {render :edit}
    end
    update.with(params[:business_profile])
  end

  def new
  end

  def destroy
    destroy = DeleteBusinessProfile.new(current_user).tap do |action|
      action.on(:business_deleted_successfully) do
        flash[:notice] = "Successfully deleted the business profile."
        redirect_to business_profiles_path
      end
      action.on(:business_deletion_failed) do
        flash[:notice] = "Could not delete the business profile."
        redirect_to business_profiles_path
      end
    end
    destroy.with(params)
  end


  def show
  end

  private

  def business_profile
    # TODO extract into a finder/query object
    @business_profile = (BusinessProfile.find_by_id(params[:id]) || BusinessProfile.new).tap do |business_profile|
      business_profile.build_username unless business_profile.username
      business_profile.build_business_profile_facebook unless business_profile.business_profile_facebook
      business_profile.build_business_profile_google unless business_profile.business_profile_google
      business_profile.build_business_profile_twitter unless business_profile.business_profile_twitter

      # show at least one / primary category
      business_profile.business_profile_categories.build unless business_profile.primary_business_category

      # workaround for multiple new categories, reform needs to have existing objects to validate against
      if params[:business_profile] && params[:business_profile][:business_profile_categories_attributes]
        (params[:business_profile][:business_profile_categories_attributes].size - business_profile.business_profile_categories.size).times do
          business_profile.business_profile_categories.build
        end
      end
    end
  end

  def business_profile_params
    params.require(:business_profile).permit!
  end
  helper_method :business_profile

  def create_edit_form
    @form = BusinessProfileForm.new(business_profile)
  end
end
