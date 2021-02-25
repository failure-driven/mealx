module Resolvers
  class SearchSuggestion < Resolvers::BaseResolver
    argument :search_text, String, required: true

    type [Types::SearchSuggestion], null: false

    def resolve(search_text:) # rubocop:disable Metrics/AbcSize
      search_text_tokens = search_text.scan(/\w+/)
      last_search_text_token = search_text_tokens.last
      suggestions = Location
                    .all
                    .map(&:menu_text)
                    .join("\n")
                    .scan(/\w+|\W/)
                    .map(&:downcase)
                    .uniq
                    .sort
                    .filter { |w| w =~ /#{last_search_text_token}/ }
                    .first(20)

      suggestions.map { |suggestion| OpenStruct.new(text: [search_text_tokens[0...-1] | [suggestion]].join(" ")) }
    end
  end
end
