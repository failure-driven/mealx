module Resolvers
  class Meals < Resolvers::BaseResolver
    argument :query, String, required: true

    type [Types::Meal], null: false

    def resolve(query:)
      ::Meal
        .where(
          Meal
            .arel_table[:name]
            .matches('%' + query + '%'),
        )
    end
  end
end
