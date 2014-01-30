module FlashHelper
  def bootstrap_class_for_flash(level)
    case level
      when :notice then "info"
      when :error then "danger"
      when :alert then "warning"
      else level.to_s
    end
  end

  def form_error_messages!(form)
    return if form.errors.empty?

    form.errors.full_messages.map do |message|
      render(partial: "layouts/alert", locals: {level: :error, message: message}).to_s
    end.join.html_safe
  end
end
