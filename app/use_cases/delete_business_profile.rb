class DeleteBusinessProfile
  include Wisper::Publisher

  attr_reader :user, :mapper

  def initialize(user, mapper = BusinessProfileMapper.new)
    @user = user
    @mapper = mapper
  end

  def with(params)
    # TODO should not be able to delete if there are messages for the business !!!
    # TODO https://github.com/apotonick/reform/issues/20
    # TODO fails from mapper are not displayed at all !!!
    if mapper.delete(params)
      broadcast(:business_deleted_successfully)
    else
      broadcast(:business_deletion_failed)
    end
  end
end