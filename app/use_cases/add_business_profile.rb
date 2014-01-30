class AddBusinessProfile
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
        mapper.create_for_owner(user, nested)
      end
      if business_profile
        broadcast(:business_profile_added_successfully, business_profile)
      else
        broadcast(:business_profile_adding_failed, form)
      end
    else
      broadcast(:business_profile_adding_failed, form)
    end
  end
end
