class Api::V1::PlacesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter  :verify_authenticity_token
  respond_to :json

  def index
    @places = Place.where(name: params[:name])
    respond_with @places
  end

  def create
    @place = Place.new(place_params)
    @place.is_api = true
    if @place.save
      render json: @place
    else
      render json: {errors: @place.errors, status: :unprocessable_entity}
    end
  end

  private
  def place_params
    params.require(:place).permit!
  end
end
