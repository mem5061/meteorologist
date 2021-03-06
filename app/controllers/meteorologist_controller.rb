require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

street_address_formatted = @street_address.gsub(" ","+")
  url = "http://maps.googleapis.com/maps/api/geocode/json?address="+street_address_formatted
  open(url).read
  raw_data = open(url).read
  parsed_data = JSON.parse(raw_data)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

@lat = @latitude.to_s
@lng = @longitude.to_s

    url_forecast = "https://api.darksky.net/forecast/892af012dfab03ff1d854abdf998ea7a/"+@lat+","+@lng
    open(url_forecast).read
    raw_data_forecast = open(url_forecast).read
    parsed_data_forecast = JSON.parse(raw_data_forecast)

    @current_temperature = parsed_data_forecast["currently"]["temperature"]

    @current_summary = parsed_data_forecast["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_forecast["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_forecast["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_forecast["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
