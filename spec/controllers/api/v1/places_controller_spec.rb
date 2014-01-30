require 'spec_helper'

describe Api::V1::PlacesController do
  login_user

  it "should list places based on name" do
    place = FactoryGirl.create(:place, name: "test")
    get :index, name: "test", format: :json
    expect(assigns(:places)).to include(place)
  end

  it "should create a new place" do
    Place.any_instance.stub(:valid?).and_return(true)
    expect{post :create, place: {name: "new place"}, format: :json}.to change{Place.count}.by(1)
  end
end
