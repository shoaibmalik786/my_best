class UserMapper
  attr_reader :logger

  def initialize(logger = Rails.logger)
    @logger = logger
  end

  # TODO test error messages from this layer, true/false is not enough
  # TODO since using save instead of save!, errors will not get propagated at all, see https://github.com/apotonick/reform/issues/20
  # TODO maybe use autosave to avoid transaction, might also help with error messages
  def save(user)
    begin
      ActiveRecord::Base.transaction do
        user.save
        user.username.save if user.username && user.username.changed?
        user.twitter_user_info.save if user.twitter_user_info && user.twitter_user_info.changed?
        user.google_user_info.save if user.google_user_info && user.google_user_info.changed?
        user.facebook_user_info.save if user.facebook_user_info && user.facebook_user_info.changed?
      end
      true
    rescue ActiveRecord::RecordNotSaved => e
      logger.error e.message
      e.backtrace.each { |line| logger.error line }
      false
    end
  end
end
