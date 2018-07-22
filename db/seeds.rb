# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require './app/models/condition.rb'
require 'csv'


CSV.foreach('./db/csv/weather.csv', headers: true, header_converters: :symbol) do |condition|
  Condition.create(cond_date: Date.strptime(condition[:date], '%m/%d/%Y'),
                   max_temperature: condition[:max_temperature_f],
                   mean_temperature: condition[:mean_temperature_f],
                   min_temperature: condition[:min_temperature_f],
                   mean_humidity: condition[:mean_humidity],
                   mean_visibility: condition[:mean_visibility_miles],
                   mean_wind_speed: condition[:mean_wind_speed_mph],
                   precipitation: condition[:precipitation_inches]
                )
end

CSV.foreach('./db/csv/station.csv', headers: true, header_converters: :symbol) do |station|
  Station.create(name: station[:name],
                 city: station[:city],
                 dock_count: station[:dock_count],
                 installation_date: DateTime.strptime(station[:installation_date], '%m/%d/%Y')
                )
end

ActiveRecord::Base.connection.reset_pk_sequence!('stations')
