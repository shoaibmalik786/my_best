class Api::V1::MessagesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter  :verify_authenticity_token
  respond_to :json

  def index
    @messages = current_user.owned_messages
    respond_with(@messages)
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      render json: @message
    else
      render json: {errors: @message.errors, status: unprocessable_entity}
    end
  end

  private
  def message_params
    params.require(:message).permit!
  end
end
