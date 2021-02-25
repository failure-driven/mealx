module Resolvers
  class MenuSearch < Resolvers::BaseResolver
    argument :query, String, required: true

    type Types::MenuSearch, null: false

    def resolve(query:)
      location_query = ::Location.search_by_menu(query)

      OpenStruct.new(
        record_count: location_query.count,
        locations: location_query.limit(100),
      )
    end
  end
end
