class BusinessCategoriesController < ApplicationController
  skip_before_action :authenticate_user!

  respond_to :json

  def search
    respond_with(BusinessCategory.search_by_name(params[:name]))
  end
end
