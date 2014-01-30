class Api::V1::UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:create, :index]
  skip_before_filter  :verify_authenticity_token

  respond_to :json

  def index
    if current_user
      @user = current_user
      respond_with @user
    else
      @user = User.find_by_email(params[:user][:email])
      if @user && @user.valid_password?(params[:user][:password])
        render json: {auth_token: @user.authentication_token}
      else
        render json: {error: "Wrong email or password"}, status: 401
      end
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  #def destroy
    #@user = current_user
    #@user.destroy
    #render json: @user
  #end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :photo, :first_name, :middle_name, :last_name)
  end
end
