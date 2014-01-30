class StatesController < ApplicationController
  skip_before_action :authenticate_user!

  respond_to :json

  def search
    respond_with(StateMapper.new.search(params))
  end
end
