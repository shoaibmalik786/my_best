class GetMessagesForHomePage
  attr_reader :user

  def with(user)
    #user ? get_messages_for_location(reverse_geocode_for(user)) : get_all_messages
    get_all_messages
  end

  private

  def get_all_messages
    Message.all.order(created_datetime: :desc).take(20)
  end
end