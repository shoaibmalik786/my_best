module MessagesHelper
  def bootstrap_class_for_message_status(message)
    case message.message_status_id.to_s
      when "saved" then "primary"
      when "paused" then "warning"
      when "running" then "success"
      when "stopped" then "danger"
      else "default"
    end
  end
end
