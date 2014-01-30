require 'spec_helper'

describe Api::V1::MessagesController do
  login_user

  it "should list all messages" do
    business_profile = FactoryGirl.create(:business_profile, user: @user)
    message = FactoryGirl.create(:message, author: @user, business_profile: business_profile)
    get :index, format: :json
    expect(assigns(:messages)).to include(message)
    expect(response.body).to_not be_empty
  end

  it "should create a message" do
    post :create, message: {description: "A message"}
  end
end
