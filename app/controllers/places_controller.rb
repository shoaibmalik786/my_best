class PlacesController < ApplicationController
  skip_before_action :authenticate_user!

  respond_to :json

  def search
    respond_with FactualService.new.find_places(params[:name], params[:latitude], params[:longitude])
  end
end
