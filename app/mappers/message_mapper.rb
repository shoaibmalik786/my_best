class MessageMapper
  attr_reader :logger

  def initialize(logger = Rails.logger)
    @logger = logger
  end

  def create_for_author(author, params)
    save(Message.new, author, params)
  end

  def update(id, params)
    save(Message.find(id), nil, params)
  end

  def set_status_paused(id)
    message = Message.find(id)
    message.message_status_id = :paused
    persist(message)
  end

  def set_status_playing(id)
    message = Message.find(id)
    message.message_status_id = :running
    persist(message)
  end

  def set_status_stopped(id)
    message = Message.find(id)
    message.message_status_id = :stopped
    persist(message)
  end

  def set_status_saved(id)
    message = Message.find(id)
    message.message_status_id = :saved
    persist(message)
  end

  def delete(params)
    Message.find(params[:id]).destroy
  end

  private

  def save(message, author, params)
    persist(fill_from_params(message, author, params))
  end

  def message_params(params)
    message_params = default_message_params.merge(ActionController::Parameters.new(params).permit!)
    message_params.reject! { |key, value| key =~ /.*_name/ || %w{place}.include?(key) }
    message_params
  end

  def default_message_params
    {
        isfacebookshare: false,
        isgoogleplusshare: false,
        istwittershare: false,
        message_status_id: :saved,
        message_source_id: :user,
        crawl_insert_date: nil,
        api_insert_date: nil
    }
  end

  def place_params(params)
    ActionController::Parameters.new(params[:place]).permit!.reject { |key, value| key =~ /.*_name/ || %w{place_id}.include?(key) }
  end

  def fill_from_params(message, author, params)
    message.tap do |message|
      message.attributes = message_params(params)
      message.author = author if author
      build_message_execution_place(message, params)
      copy_coordinates_from_place(message)
    end
  end

  def persist(message)
    begin
      ActiveRecord::Base.transaction do
        message.save
        message.place.save if message.place && message.place.changed?
      end
      message
    rescue ActiveRecord::RecordNotSaved => e
      logger.error e.message
      e.backtrace.each { |line| logger.error line }
      false
    end
  end

  def build_message_execution_place(message, params)
    place_params = place_params(params)
    factual_id = place_params[:factual_id]

    if message.place && message.place.factual_id == factual_id
      place = place_differs?(message.place, place_params) ? build_custom_place(message, place_params) : message.place
    else
      place = Place.find_by(factual_id: factual_id)
      if place
        place = place_differs?(place, place_params) ? build_custom_place(message, place_params) : place
      else
        place = build_place(message, place_params)
      end
    end

    message.place = place
  end

  def build_custom_place(message, place_params)
    build_place(message, place_params).tap do |place|
      place.factual_id = nil
      #place.latitude = nil
      #place.longitude = nil
    end
  end

  def build_place(message, place_params)
    message.build_place(place_params)
  end

  def place_differs?(place, params)
    params.find { |key, value| place.send(key).to_s != value.to_s } != nil
  end

  def copy_coordinates_from_place(message)
    message.latitude = message.place.latitude
    message.longitude = message.place.longitude
  end
end
