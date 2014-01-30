class SetMessageStatusPlaying
  include Wisper::Publisher

  attr_reader :mapper

  def initialize(mapper = MessageMapper.new)
    @mapper = mapper
  end

  def with(params)
    # TODO fails from mapper are not displayed at all !!!
    if mapper.set_status_playing(params[:id])
      broadcast(:message_status_set_to_playing_successfully)
    else
      broadcast(:message_status_set_to_playing_failed)
    end
  end
end