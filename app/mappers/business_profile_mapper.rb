class BusinessProfileMapper
  attr_reader :logger

  def initialize(logger = Rails.logger)
    @logger = logger
  end

  def create_for_owner(owner, params)
    save(BusinessProfile.new, owner, params)
  end

  def update(id, params)
    save(BusinessProfile.find(id), nil, params)
  end

  def delete(params)
    # TODO check for existing messages
    # TODO delete manually all relations, do not rely on dependant: :destroy
    BusinessProfile.find(params[:id]).destroy
  end

  private

  def save(business_profile, owner, params)
    persist(*fill_from_params(business_profile, owner, params))
  end

  def business_params(params)
    ActionController::Parameters.new(params).permit!.reject do |key, value|
      key =~ /.*_name/ ||
      key =~ /.*_code$/ ||
      %w{username business_profile_categories business_profile_facebook business_profile_google business_profile_twitter}.include?(key)
    end
  end

  def place_params(params)
    business_params(params).select { |key, value| %w{name address}.include?(key) }
  end

  def username_params(params)
    ActionController::Parameters.new(params[:username]).permit!
  end

  def business_category_params(params)
    ActionController::Parameters.new(params).permit!.reject { |key, value| key =~ /.*_name/ }
  end

  def business_profile_facebook_params(params)
    facebook_params = ActionController::Parameters.new(params[:business_profile_facebook]).permit!
    facebook_params[:uid] = nil if facebook_params[:uid] && facebook_params[:uid].empty?
    facebook_params
  end

  def business_profile_google_params(params)
    google_params = ActionController::Parameters.new(params[:business_profile_google]).permit!
    google_params[:uid] = nil if google_params[:uid] && google_params[:uid].empty?
    google_params
  end

  def business_profile_twitter_params(params)
    twitter_params = ActionController::Parameters.new(params[:business_profile_twitter]).permit!
    twitter_params[:uid] = nil if twitter_params[:uid] && twitter_params[:uid].empty?
    twitter_params
  end

  def fill_from_params(business_profile, owner, params)
    business_profile.tap do |business_profile|
      business_profile.attributes = business_params(params)
      business_profile.user = owner if owner
      (business_profile.place || business_profile.build_place).attributes = place_params(params)
      (business_profile.username || business_profile.build_username).attributes = username_params(params)
      (business_profile.business_profile_facebook || business_profile.build_business_profile_facebook).attributes = business_profile_facebook_params(params)
      (business_profile.business_profile_google || business_profile.build_business_profile_google).attributes = business_profile_google_params(params)
      (business_profile.business_profile_twitter || business_profile.build_business_profile_twitter).attributes = business_profile_twitter_params(params)
    end
    return business_profile, build_business_profile_categories(business_profile, params)
  end

  def persist(business_profile, business_profile_categories)
    begin
      ActiveRecord::Base.transaction do
        business_profile.business_profile_categories.each(&:delete)
        business_profile.business_profile_categories << business_profile_categories
        business_profile.save
        business_profile.place.save
        business_profile.business_profile_facebook.save if business_profile.business_profile_facebook && business_profile.business_profile_facebook.changed?
        business_profile.business_profile_google.save if business_profile.business_profile_google && business_profile.business_profile_google.changed?
        business_profile.business_profile_twitter.save if business_profile.business_profile_twitter && business_profile.business_profile_twitter.changed?
      end
      business_profile
    rescue ActiveRecord::RecordNotSaved => e
      logger.error e.message
      e.backtrace.each { |line| logger.error line }
      false
    end
  end

  def build_business_profile_categories(business_profile, params)
    params[:business_profile_categories].each_with_index.map do |params, index|
      BusinessProfileCategory.new(business_category_params(params.merge({category_type: index + 1})))
    end
  end
end