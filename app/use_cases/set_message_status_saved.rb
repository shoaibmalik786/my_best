class SetMessageStatusSaved
  include Wisper::Publisher

  attr_reader :mapper

  def initialize(mapper = MessageMapper.new)
    @mapper = mapper
  end

  def with(params)
    # TODO fails from mapper are not displayed at all !!!
    if mapper.set_status_saved(params[:id])
      broadcast(:message_status_set_to_saved_successfully)
    else
      broadcast(:message_status_set_to_saved_failed)
    end
  end
end