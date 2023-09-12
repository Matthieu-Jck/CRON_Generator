require 'net/http'
require 'json'

url = URI("https://api.nasa.gov/insight_weather/?api_key=qlDL7aSsPYvtXmlOhswtisUdfyAfrP4xrpwQQOFn&feedtype=json&ver=1.0")
response = Net::HTTP.get(url)
data = JSON.parse(response)

if data['sol_keys'] && !data['sol_keys'].empty?
  first_sol = data['sol_keys'].first
  weather_data = data[first_sol]

  # Check if weather data is present
  if weather_data
    File.open("README.md", "w") do |file|
      file.puts "# Mars Weather Report\n"
      file.puts "Weather data for Sol #{first_sol}:\n"
      file.puts "- Season: #{weather_data['Season']}"
      file.puts "- First UTC: #{weather_data['First_UTC']}"
      file.puts "- Last UTC: #{weather_data['Last_UTC']}"
      file.puts "\n**Atmospheric Temperature (°C):**"
      file.puts "- Average: #{weather_data.dig('AT', 'av')}"
      file.puts "- Minimum: #{weather_data.dig('AT', 'mn')}"
      file.puts "- Maximum: #{weather_data.dig('AT', 'mx')}"
      file.puts "\n**Horizontal Wind Speed (m/s):**"
      file.puts "- Average: #{weather_data.dig('HWS', 'av')}"
      file.puts "- Minimum: #{weather_data.dig('HWS', 'mn')}"
      file.puts "- Maximum: #{weather_data.dig('HWS', 'mx')}"
      file.puts "\n**Atmospheric Pressure (Pa):**"
      file.puts "- Average: #{weather_data.dig('PRE', 'av')}"
      file.puts "- Minimum: #{weather_data.dig('PRE', 'mn')}"
      file.puts "- Maximum: #{weather_data.dig('PRE', 'mx')}"
    end
  else
    puts "Weather data not available for Sol #{first_sol}"
  end
else
  puts "No sol_keys available in the API response"
end
