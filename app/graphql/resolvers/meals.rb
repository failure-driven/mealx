module Resolvers
  class Meals < Resolvers::BaseResolver
    argument :query, String, required: true

    type [Types::Meal], null: false

    def resolve(query:)
      # TODO: query length should be set on client
      return ::Meal.none if query.empty?

      ::Meal
        .where(
          Meal
            .arel_table[:name]
            .matches("%#{query}%"),
        ).limit(100)
    end
  end
end
