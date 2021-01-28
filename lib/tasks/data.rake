require "colorize"

def call_operation(operation, query_params) # rubocop:disable Metrics/AbcSize
  uri = URI.parse("https://developers.zomato.com/api/v2.1/#{operation}")
  params = URI.decode_www_form(uri.query || "").to_h.merge(query_params)
  uri.query = URI.encode_www_form(params)
  puts uri.to_s
  request = Net::HTTP::Get.new uri
  request["Accept"] = "application/json"
  request["user-key"] = Rails.application.credentials.zomato[:api_key]
  response = Net::HTTP.start(
    uri.host,
    uri.port,
    use_ssl: uri.scheme == "https",
  ) do |http|
    http.request request
  end

  # ap JSON.parse(response.body)
  puts JSON.pretty_generate(JSON.parse(response.body)).yellow
end

def fetch_using_cache(uri, cache_dir, cached: false) # rubocop:disable Metrics/AbcSize
  uri_filename = [uri.path, uri.query]
                 .compact
                 .join("?")
                 .gsub(%r{^/}, "")
                 .gsub(%r{/}, "-")
                 .gsub(/\?/, "-")
                 .gsub("&", "-")
                 .gsub(/=/, "-")
  uri_filename = File.join(cache_dir, uri_filename)
  if !cached && !(File.exist? uri_filename)
    request = Net::HTTP::Get.new uri
    request["user-agent"] = "Mozilla/5.0"
    request["Cookie"] = ""
    response = Net::HTTP.start(
      uri.host,
      uri.port,
      use_ssl: uri.scheme == "https",
    ) do |http|
      http.request request
    end
    if response.is_a?(Net::HTTPSuccess)
      File.open(uri_filename, "wb") do |io|
        io.write response.body
      end
    end
    sleep(rand(1..5)) # random sleep 1 - 5 seconds
  end
  File.open(uri_filename).read if File.exist? uri_filename
  # TODO: what to do if there is no file still?
end

namespace :data do
  desc "Zomato API demo"
  task zomato_api_demo: :environment do
    [
      {
        operation: :cities,
        query_params: { q: "Melbourne" },
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
        query_params: { res_id: 18_528_054 },
        notes: "NOT SUPPORTED",
      },
      {
        operation: :restaurant,
        query_params: { res_id: 18_528_054 },
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

  desc "Location scraper [start_location,cache_dir=tmp,cached]"
  task :location_scraper, [:start_location, :cache_dir, :cached] => :environment do |_task, args|
    cache_dir = args[:cache_dir] || "tmp/location_scraper"
    cached = !args[:cached].nil? || false
    FileUtils.mkdir_p cache_dir

    uri = URI.parse(args[:start_location])
    loop do
      puts "fetching uri: #{uri}"
      body = fetch_using_cache(uri, cache_dir, cached: cached)
      doc = Nokogiri::HTML.parse(body)
      locations = doc
                  .css("article")
                  .map do |article|
        {
          location: article.css("a.result-title").text.strip,
          address: article.css("div.search-result-address").text.strip,
          hours: article.css("div.res-timing").attr("title")&.value,
          link: article.css("a.result-title").attr("href").value,
        }
      end
      locations.each do |location|
        # NOTE: URI.escape is obsolete
        #   https://rubyapi.org/2.7/o/uri/escape
        #   URI.escape method is obsolete and should not be used. Instead, use CGI.escape,
        #   URI.encode_www_form or URI.encode_www_form_component depending on your
        #   specific use case.
        body = fetch_using_cache(
          URI.parse(URI.escape(location[:link])), # rubocop:disable Lint/UriEscapeUnescape
          cache_dir,
          cached: cached,
        )
        matched = /.*JSON.parse\((.*)\)$/.match body
        next unless matched && matched[1]

        json_data = JSON.parse(JSON.parse(matched[1]))
        restaurant_id = json_data.dig("pages", "current", "resId").to_s
        name = json_data.dig("pages", "current", "ogTitle")
        timings = json_data.dig(
          "pages",
          "restaurant",
          restaurant_id,
          "sections",
          "SECTION_BASIC_INFO",
          "timing",
        )
        address = json_data.dig(
          "pages",
          "restaurant",
          restaurant_id,
          "sections",
          "SECTION_RES_CONTACT",
          "address",
        )
        latitude = json_data.dig(
          "pages",
          "restaurant",
          restaurant_id,
          "sections",
          "SECTION_RES_CONTACT",
          "latitude",
        )
        longitude = json_data.dig(
          "pages",
          "restaurant",
          restaurant_id,
          "sections",
          "SECTION_RES_CONTACT",
          "longitude",
        )
        phone = json_data.dig(
          "pages",
          "restaurant",
          restaurant_id,
          "sections",
          "SECTION_RES_CONTACT",
          "phoneDetails",
          "phoneStr",
        )
        restaurant_details = {
          restaurant_id: restaurant_id,
          timings: timings,
          name: name,
          address: address,
          longitude: longitude,
          latitude: latitude,
          phone: phone,
        }
        menu_uri_path = json_data.dig(
          "pages",
          "restaurant",
          restaurant_id,
          "navbarSection",
        ).find { |section| section["subType"] == "menu" }
        menu_uri_path = menu_uri_path["pageUrl"] if menu_uri_path
        if menu_uri_path
          menu_url = URI.parse(
            [
              uri.scheme,
              "://",
              uri.host,
              URI.escape(menu_uri_path), # rubocop:disable Lint/UriEscapeUnescape
            ].join,
          )
          restaurant_details.merge!({
                                      menu_url: menu_url.to_s,
                                    })
          # binding.pry
          body_menu = fetch_using_cache(menu_url, cache_dir, cached: cached)
          matched = /.*JSON.parse\((.*)\)$/.match body_menu
          if matched && matched[1]
            json_data_menu = JSON.parse(JSON.parse(matched[1]))
            menu_urls = json_data_menu.dig(
              "pages",
              "restaurant",
              restaurant_id,
              "sections",
              "SECTION_IMAGE_MENU",
              "menuItems",
            )
                                      .find { |e| e["label"] == "Menu" }
              &.dig("pages")
              &.map { |e| e["url"] }
            restaurant_details.merge!({
                                        menu_urls: menu_urls,
                                      })
            menu_urls&.each do |menu_image_url|
              fetch_using_cache(URI(menu_image_url), cache_dir, cached: cached)
            end
          end
        end
        ap restaurant_details
      end
      ap locations
      uri = URI.parse(
        [
          uri.scheme,
          "://",
          uri.host,
          doc.css(".search-pagination-top a.next").attr("href"),
        ].join,
      )
      break unless uri
    end
  end
end
