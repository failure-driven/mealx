module Resolvers
  class MenuSearch < Resolvers::BaseResolver
    argument :query, String, required: true

    type Types::MenuSearch, null: false

    def resolve(query:) # rubocop:disable Metrics/AbcSize
      location_query = ::Location.none
      # TODO: much to be desired for a search with some kind of relevancy
      #   matching all terms, number of matches per term, partial matches,
      #   misspellings etc
      query_words = query.split(/\W+/)
      if !query.empty? && query_words.map(&:length).max > 2
        location_query = ::Location
                         .where(
                           Location
                             .arel_table[:menu_text]
                             .matches_all(query_words.filter { |word| word.length > 2 }.map { |word| "%#{word}%" }),
                         ).distinct
      end

      OpenStruct.new(
        record_count: location_query.count,
        locations: location_query.limit(100),
      )
    end
  end
end
