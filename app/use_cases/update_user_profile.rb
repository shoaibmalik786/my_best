class UpdateUserProfile
  include Wisper::Publisher

  attr_reader :form, :mapper

  def initialize(form, mapper = UserProfileMapper.new)
    @form = form
    @mapper = mapper
  end

  def with(params)
    # TODO fails from mapper are not displayed at all !!!
    if form.validate(params)
      user = form.save do |data, nested|
        mapper.update(form.id, nested)
      end
      broadcast(:user_profile_updated_successfully, user)
    else
      broadcast(:user_profile_update_failed, form)
    end
  end
end