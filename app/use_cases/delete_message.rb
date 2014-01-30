class DeleteMessage
  include Wisper::Publisher

  attr_reader :user, :mapper

  def initialize(user, mapper = MessageMapper.new)
    @user = user
    @mapper = mapper
  end

  def with(params)
    # TODO should not be able to delete if messages is broadcast to the actual consumers !!!
    # TODO https://github.com/apotonick/reform/issues/20
    # TODO fails from mapper are not displayed at all !!!
    if mapper.delete(params)
      broadcast(:message_deleted_successfully)
    else
      broadcast(:message_deletion_failed)
    end
  end
end
