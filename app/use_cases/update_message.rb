class UpdateMessage
  include Wisper::Publisher

  attr_reader :user, :form, :mapper

  def initialize(user, form, mapper = MessageMapper.new)
    @user = user
    @form = form
    @mapper = mapper
  end

  def with(params)
    # TODO fails from mapper are not displayed at all !!!
    set_frequency_time(params)
    if form.validate(params)
      message = form.save do |data, nested|
        mapper.update(form.id, nested)
      end
      broadcast(:message_updated_successfully, message)
    else
      broadcast(:message_update_failed, form)
    end
  end

  private

  def set_frequency_time(params)
    time = Time.new(Time.now.year, Time.now.month, Time.now.day, params["frequency_time(4i)"] || 20, params["frequency_time(5i)"] || 0, 0, "+00:00")
    params[:frequency_time] ||= time
  end
end