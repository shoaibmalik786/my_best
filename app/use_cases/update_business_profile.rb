class UpdateBusinessProfile
  include Wisper::Publisher

  attr_reader :user, :form, :mapper

  def initialize(user, form, mapper = BusinessProfileMapper.new)
    @user = user
    @form = form
    @mapper = mapper
  end

  def with(params)
    # TODO fails from mapper are not displayed at all !!!
    if form.validate(params)
      business_profile = form.save do |data, nested|
        mapper.update(form.id, nested)
      end
      broadcast(:business_profile_updated_successfully, business_profile)
    else
      broadcast(:business_profile_update_failed, form)
    end
  end
end