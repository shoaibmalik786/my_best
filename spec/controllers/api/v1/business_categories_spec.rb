require 'spec_helper'

describe Api::V1::BusinessCategoriesController do
  it "should list categories based on search" do
    get :index, name: "Technology", format: :json
    expect(assigns(:business_categories)).to_not be_empty
  end
end
