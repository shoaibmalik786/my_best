class FixMessageAndPlaceData < ActiveRecord::Migration
  def up
    Place.where("latitude is null or longitude is null").each do |place|
      place.factual_id = nil
      place.save
    end

    Message.all.each do |message|
      unless message.latitude && message.longitude
        message.latitude ||= message.place.latitude
        message.longitude ||= message.place.longitude
        message.save
      end
    end
  end

  def down
  end
end
