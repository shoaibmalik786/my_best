class ZipCodesController < ApplicationController
  skip_before_action :authenticate_user!

  respond_to :json

  def search
    respond_with(ZipCodeMapper.new.search(params))
  end
end
