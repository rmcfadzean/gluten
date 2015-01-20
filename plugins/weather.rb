require 'open_weather'

module Gluten::Plugins
  class Weather
    include Gluten::Plugin
    include Cinch::Plugin

    match /weather ?(.*)/, method: :get_weather

    def get_weather msg, location
      location = $redis.get("settings.#{msg.user.nick}.location") if location.empty?

      weather = format_message(OpenWeather::Current.city(location, units: 'metric'))

      msg.reply weather
    end


    def format_message weather
      p weather
      return weather['message'] if weather['message']
      "#{weather['name']}, #{weather['sys']['country']} - #{weather['weather'].first['description']} | #{weather['main']['temp']}°C | Humidity: #{weather['main']['humidity']}% | Wind: #{weather['wind']['speed']}km/h"
    end

  end
end
