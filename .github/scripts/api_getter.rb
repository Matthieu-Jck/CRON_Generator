require 'net/http'
require 'json'

url = URI("https://api.nasa.gov/insight_weather/?api_key=qlDL7aSsPYvtXmlOhswtisUdfyAfrP4xrpwQQOFn&feedtype=json&ver=1.0")
response = Net::HTTP.get(url)
data = JSON.parse(response)

# Get the first available sol
first_sol = data['sol_keys'].first

# Get the weather data for the first available sol
weather_data = data[first_sol]

# Create or open README.md and write the data to it
File.open("README.md", "w") do |file|
  file.puts "# Mars Weather Report\n"
  file.puts "Weather data for Sol #{first_sol}:\n"
  file.puts "- Season: #{weather_data['Season']}"
  file.puts "- First UTC: #{weather_data['First_UTC']}"
  file.puts "- Last UTC: #{weather_data['Last_UTC']}"
  file.puts "\n**Atmospheric Temperature (°C):**"
  file.puts "- Average: #{weather_data['AT']['av']}"
  file.puts "- Minimum: #{weather_data['AT']['mn']}"
  file.puts "- Maximum: #{weather_data['AT']['mx']}"
  file.puts "\n**Horizontal Wind Speed (m/s):**"
  file.puts "- Average: #{weather_data['HWS']['av']}"
  file.puts "- Minimum: #{weather_data['HWS']['mn']}"
  file.puts "- Maximum: #{weather_data['HWS']['mx']}"
  file.puts "\n**Atmospheric Pressure (Pa):**"
  file.puts "- Average: #{weather_data['PRE']['av']}"
  file.puts "- Minimum: #{weather_data['PRE']['mn']}"
  file.puts "- Maximum: #{weather_data['PRE']['mx']}"
end
