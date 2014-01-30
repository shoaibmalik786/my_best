module NavigationHelper
  def editing?
    %w{update edit}.include?(action_name)
  end

  def has_business_profiles?
    current_user.has_business_profiles?
  end
end
