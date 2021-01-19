module Resolvers
  class Locations < Resolvers::BaseResolver
    argument :meal_names, [String], required: true

    type [Types::Location], null: false

    def resolve(meal_names:)
      ::Location
        .joins(location_meals: :meal)
        .where(
          Meal
            .arel_table[:name]
            .matches_any(meal_names),
        )
    end
  end
end
