require 'colorize'

def call_operation(operation, query_params)
  uri = URI.parse("https://developers.zomato.com/api/v2.1/#{operation}")
  params = URI.decode_www_form(uri.query || '').to_h.merge(query_params)
  uri.query = URI.encode_www_form(params)
  puts uri.to_s
  request = Net::HTTP::Get.new uri 
  request["Accept"] = "application/json"
  request["user-key"] = Rails.application.credentials.zomato[:api_key]
  response = Net::HTTP.start(
    uri.host,
    uri.port, 
    use_ssl: uri.scheme == 'https'
  ) do |http|
    http.request request
  end

  # ap JSON.parse(response.body)
  puts JSON.pretty_generate(JSON.parse(response.body)).yellow
end

namespace :data do
  desc "Zomato API demo"
  task zomato_api_demo: :environment do
    [
      {
        operation: :cities,
        query_params: { q: "Melbourne"},
        notes: "NOT USEFUL",
      },
      {
        operation: :geocode,
        query_params: { lat: -37.774, lon: 144.997 },
        notes: <<~EOF_NOTES.strip,
          GOOD for:
          \t- nearby restaurants
          \t- restaurant location and addresses and images
        EOF_NOTES
      },
      {
        operation: :locations,
        query_params: { query: "Australia", lat: -37.774, lon: 144.997 },
        notes: "NOT USEFUL",
      },
      {
        operation: :dailymenu,
        query_params: { res_id:18528054 },
        notes: "NOT SUPPORTED",
      },
      {
        operation: :restaurant,
        query_params: { res_id:18528054 },
        notes: <<~EOF_NOTES.strip,
          GOOD for:
          \t- address
          \t- location
          \t- timings (opening hours)
          \t- photos url
          \t- menus url
        EOF_NOTES
      },
    ].each do |operation_test|
      puts "testing #{operation_test[:operation].inspect}".green
      puts "\n"

      call_operation(operation_test[:operation], operation_test[:query_params])

      sentiment_colour = operation_test[:notes].match(/GOOD/) ? :green : :red
      puts operation_test[:notes].to_s.send(sentiment_colour)
      puts "\n\n"
    end
  end
end