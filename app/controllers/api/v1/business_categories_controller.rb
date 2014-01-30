class Api::V1::BusinessCategoriesController < ApplicationController
  skip_before_action :authenticate_user!, :verify_authenticity_token

  respond_to :json

  def index
    @business_categories = BusinessCategory.search_by_name(params[:name])
    respond_with @business_categories
  end
end
