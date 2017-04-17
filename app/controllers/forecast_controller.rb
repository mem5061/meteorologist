require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

url_forecast = "https://api.darksky.net/forecast/892af012dfab03ff1d854abdf998ea7a/"+@lat+","+@lng
open(url_forecast).read
raw_data_forecast = open(url_forecast).read
parsed_data_forecast = JSON.parse(raw_data_forecast)

    @current_temperature = parsed_data_forecast["currently"]["temperature"]

    @current_summary = parsed_data_forecast["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_forecast["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_forecast["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_forecast["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
