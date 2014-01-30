class AddressesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @addresses = current_user.user_addresses.order(:address_id)
  end

  def new
    @address = current_user.user_addresses.build
  end

  def create
    @address = UserAddress.new(address_params)
    @address.user_id = current_user.id

    if @address.save
      redirect_to addresses_path
    else
      render :new
    end
  end

  def edit
    @address = current_user.user_addresses.find(params[:id])
  end

  def update
    @address = current_user.user_addresses.find(params[:id])
    if @address.update_attributes(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = current_user.user_addresses.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  def make_main
    @address = current_user.user_addresses.find(params[:id])
    if @address
      current_user.user_addresses.each do |address|
        if address == @address
          address.update_attribute(:main, true)
        else
          address.update_attribute(:main, false)
        end
      end
    end
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:user_address).permit(:address_one, :lat, :lng)
  end
end
