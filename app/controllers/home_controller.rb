class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_filter except: [:fill_email, :update_email] do
    if current_user && !current_user.email
      redirect_to fill_email_path
    end
  end

  respond_to :all

  def index
    @messages = GetMessagesForHomePage.new.with(current_user)
    respond_with(@messages)
  end

  def fill_email
  end

  def update_email
    if current_user && !current_user.email
      user = current_user
      user.email = params[:email]
      user.password = params[:password]
      user.password_confirmation = params[:password_confirmation]
      user.save
    end

    redirect_to root_path
  end
end
