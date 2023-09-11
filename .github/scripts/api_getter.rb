require 'net/http'
require 'json'

url = URI("https://api.nasa.gov/insight_weather/?api_key=qlDL7aSsPYvtXmlOhswtisUdfyAfrP4xrpwQQOFn&feedtype=json&ver=1.0")
response = Net::HTTP.get(url)
data = JSON.parse(response)

# Print the available sol keys
puts "Available Sols: #{data['sol_keys']}"

# Get the first available sol
first_sol = data['sol_keys'].first

# Get and print the weather data for the first available sol
weather_data = data[first_sol]
puts "Weather data for Sol #{first_sol}:"
puts "  Season: #{weather_data['Season']}"
puts "  First UTC: #{weather_data['First_UTC']}"
puts "  Last UTC: #{weather_data['Last_UTC']}"

puts "  Atmospheric Temperature (°C):"
puts "    Average: #{weather_data['AT']['av']}"
puts "    Minimum: #{weather_data['AT']['mn']}"
puts "    Maximum: #{weather_data['AT']['mx']}"

puts "  Horizontal Wind Speed (m/s):"
puts "    Average: #{weather_data['HWS']['av']}"
puts "    Minimum: #{weather_data['HWS']['mn']}"
puts "    Maximum: #{weather_data['HWS']['mx']}"

puts "  Atmospheric Pressure (Pa):"
puts "    Average: #{weather_data['PRE']['av']}"
puts "    Minimum: #{weather_data['PRE']['mn']}"
puts "    Maximum: #{weather_data['PRE']['mx']}"
