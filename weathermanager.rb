require "csv"
require 'erb'


rain_count = 0
sun_count = 0 

contents = CSV.open "weather.csv", headers: true, header_converters: :symbol
contents.each do |row|
	date = row[0]
	events = row[:events]
	if events != nil
		rain_count += 1
	else
		sun_count += 1
	end
end


puts "days of precipitation: #{rain_count}"
puts "days of sun: #{sun_count}"