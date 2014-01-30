require 'spec_helper'

describe Api::V1::BusinessProfilesController do
  login_user
  before(:each) do
    @business_profile = FactoryGirl.create(:business_profile, user: @user)
    business_profile_category = FactoryGirl.create(:business_profile_category, business_profile: @business_profile)
  end

  it "should list all business_profiles" do
    get :index, format: :json
    expect(assigns(:business_profiles)).to include(@business_profile)
    expect(response.body).to_not be_empty
  end

  it "should create a business profile" do
    place = FactoryGirl.create(:place)
    expect{post :create, business_profile: {places_id: place.id}}.to change{BusinessProfile.count}.by(1)
  end
end
