require 'net/http'
require 'json'

city_id = '2972315'
api_key = '8763fab78dfe2059f03dbe174ced5d97'
url = URI("http://api.openweathermap.org/data/2.5/weather?id=#{city_id}&appid=#{api_key}&units=metric")

response = Net::HTTP.get(url)
data = JSON.parse(response)

if data && data["weather"]
  weather_data = data

  File.open("README.md", "w") do |file|
    file.puts "# Current Weather Report\n"
    file.puts "Current weather data for the selected location:\n"
    file.puts "- Weather Condition: #{weather_data['weather'].first['main']}"
    file.puts "- Description: #{weather_data['weather'].first['description']}"
    file.puts "- Temperature: #{weather_data['main']['temp']}°C"
    file.puts "- Feels Like: #{weather_data['main']['feels_like']}°C"
    file.puts "- Minimum Temperature: #{weather_data['main']['temp_min']}°C"
    file.puts "- Maximum Temperature: #{weather_data['main']['temp_max']}°C"
    file.puts "- Pressure: #{weather_data['main']['pressure']} hPa"
    file.puts "- Humidity: #{weather_data['main']['humidity']}%"
    file.puts "- Wind Speed: #{weather_data['wind']['speed']} m/s"
    file.puts "- Wind Degree: #{weather_data['wind']['deg']}°"
  end
else
  puts "Weather data not available for the provided location"
end

