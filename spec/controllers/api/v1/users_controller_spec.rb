require 'spec_helper'

describe Api::V1::UsersController do
  context "Creating a user" do
    it "should create a new user" do
      User.any_instance.stub(:valid?).and_return(true)
      expect{post :create, user: {email: ""}, format: :json}.to change{User.count}.by(1)
    end

    it "should not create a new user" do
      User.any_instance.stub(:valid?).and_return(false)
      expect{post :create, user: {email: "", password: ""}, format: :json}.to change{User.count}.by(0)
    end

    it "should return a http status 422 when not saving" do
      User.any_instance.stub(:valid?).and_return(false)
      post :create, user: {email: ""}, format: :json
      expect(response.status).to eq(422)
    end
  end

  context "Updating an existing user" do
    login_user

    it "should update an existing user" do
      put :update, user: {photo: "photo"}, format: :json
      expect(assigns(:user).photo).to eq("photo")
    end

    it "should return a http status 422 when not saving" do
      User.any_instance.stub(:valid?).and_return(false)
      post :update, user: {photo: "photo"}, format: :json
      expect(response.status).to eq(422)
    end
  end

  #context "Deleting an existing user" do
    #login_user

    #it "should delete an existing user" do
      #expect{delete :destroy, format: :json}.to change{User.count}.by(-1)
    #end
  #end

  #context "Checking for a user" do
    #context "When user is signed" do
      #login_user
      #it "should return the current user" do
        #get :index
        #expect(assigns(:user)).to eq(@user)
      #end
    #end

    #context "When user is not signed" do
      #it "should return a valid user" do
        #user = FactoryGirl.create(:user)
        #get :index, user: {email: "email@email.com", password: "password"}
        #expect(assigns(:user)).to eq(user)
      #end

      #it "should return 401 if user is not found" do
        #get :index, user: {email: "invalid", password: "invalid"}
        #expect(response.status).to eq(401)
      #end
    #end
  #end
end
