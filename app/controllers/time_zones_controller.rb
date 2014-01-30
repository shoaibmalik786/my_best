require 'open-uri'

class TimeZonesController < ApplicationController
  skip_before_action :authenticate_user!

  respond_to :json

  def search
    respond_with(TimeZone.search_by_name(params[:name]))
  end

  def for_location
    respond_with fetch_time_zone_from_google
  end

  private

  def fetch_time_zone_from_google
    # http://stackoverflow.com/questions/16086962/how-to-get-a-time-zone-from-a-location
    url = "https://maps.googleapis.com/maps/api/timezone/json?location=#{params[:latitude]},#{params[:longitude]}&timestamp=1331161200&sensor=false"
    response = open(url)
    json = ActiveSupport::JSON.decode(response)
    TimeZone.find_by_code(json["timeZoneId"])
  end
end
