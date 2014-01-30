class MessagesController < ApplicationController
  before_filter :create_edit_form, except: [:index]

  respond_to :all

  def index
    #@messages = current_user.authored_messages
    @messages = current_user.owned_messages
    respond_with(@messages)
  end

  def edit
    @message = Message.find(params[:id])
    respond_with(@message)
  end

  def update
    update = UpdateMessage.new(current_user, @form).tap do |action|
      action.on(:message_updated_successfully) do |message|
        flash[:notice] = "Successfully updated the message"
        redirect_to messages_path
      end
      action.on(:message_update_failed) {render :edit}
    end
    update.with(params[:message])
  end

  def play
    play = SetMessageStatusPlaying.new.tap do |action|
      action.on(:message_status_set_to_playing_successfully) do
        flash[:notice] = "Currently broadcasting the message"
        redirect_to messages_path
      end
      action.on(:message_status_set_to_playing_failed) do
        flash[:notice] = "Could not broadcast the message"
        redirect_to messages_path
      end
    end
    play.with(params)
  end

  def stop
    stop = SetMessageStatusStopped.new.tap do |action|
      action.on(:message_status_set_to_stopped_successfully) do
        flash[:notice] = "Successfully deactivated message"
        redirect_to messages_path
      end
      action.on(:message_status_set_to_stopped_failed) do
        flash[:notice] = "Could not deactivate the message"
        redirect_to messages_path
      end
    end
    stop.with(params)
  end

  def pause
    pause = SetMessageStatusPaused.new.tap do |action|
      action.on(:message_status_set_to_paused_successfully) do
        flash[:notice] = "The message has been successfully paused"
        redirect_to messages_path
      end
      action.on(:message_status_set_to_paused_failed) do
        flash[:notice] = "Could not pause the message"
        redirect_to messages_path
      end
    end
    pause.with(params)
  end

  def save
    save = SetMessageStatusSaved.new.tap do |action|
      action.on(:message_status_set_to_saved_successfully) do
        flash[:notice] = "Successfully save the message"
        redirect_to messages_path
      end
      action.on(:message_status_set_to_saved_failed) do
        flash[:notice] = "Could not save the message"
        redirect_to messages_path
      end
    end
    save.with(params)
  end

  def new
  end

  def destroy
    destroy = DeleteMessage.new(current_user).tap do |action|
      action.on(:message_deleted_successfully) do
        flash[:notice] = "Successfully deleted the message"
        redirect_to messages_path
      end
      action.on(:message_deletion_failed) do
        flash[:notice] = "Could not delete the message"
        redirect_to messages_path
      end
    end
    destroy.with(params)
  end

  def create
    broadcast = BroadcastMessage.new(current_user, @form).tap do |action|
      action.on(:message_broadcast_successfully) do |message|
        flash[:notice] = "Successfully broadcast the message"
        redirect_to messages_path
      end
      action.on(:message_broadcast_failed) {render :new}
    end
    broadcast.with(params[:message])
  end

  def analytics
    @message = Message.find(params[:id])
    respond_with(@message)
  end

  private

  def message
    # TODO extract into a finder/query object
    @message = Message.find_by_message_id(params[:id]) || Message.new(message_type: :social_incentive).tap do |message|
      message.build_place unless message.place
    end
  end
  helper_method :message

  def create_edit_form
    @form = MessageForm.new(message)
  end
end
