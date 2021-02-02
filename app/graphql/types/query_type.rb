module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :locations,
          resolver: Resolvers::Locations,
          description: "Find locations by meal names"
    field :meals,
          resolver: Resolvers::Meals,
          description: "Find Meals by fuzzy match"
    field :menu_search,
          resolver: Resolvers::MenuSearch,
          description: "Find locations by menu search"
  end
end
