class UserProfileMapper
  def update(id, params)
    user = User.find(id).tap do |user|
      user.attributes = user_params(params)
      #user.username ? user.username.attributes = username_params(params) : user.build_username(username_params(params))
      #user.address ? user.address.attributes = address_params(params) : user.build_address(address_params(params))
      (user.username || user.build_username).attributes = username_params(params)
    end
    UserMapper.new.save(user)
  end

  private

  def user_params(params)
    ActionController::Parameters.new(params).permit!.reject { |key, value| %w(time_zone_name user_address username).include?(key) }
  end

  def username_params(params)
    ActionController::Parameters.new(params[:username]).permit!
  end

  def user_address_params(params)
    ActionController::Parameters.new(params[:user_address]).permit!.reject { |key, value| key =~ /.*_name/ || key =~ /.*_code$/ }
  end
end
