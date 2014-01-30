class CitiesController < ApplicationController
  skip_before_action :authenticate_user!

  respond_to :json

  def search
    respond_with(CityMapper.new.search(params))
  end
end