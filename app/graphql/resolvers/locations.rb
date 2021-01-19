module Resolvers
  class Locations < Resolvers::BaseResolver
    argument :meal_names, [String], required: false

    type [Types::Location], null: false

    def resolve(meal_names:)
      ::Location
        .joins(location_meals: :meal)
        .where(
          Meal
            .arel_table[:name]
            .matches_any(meal_names),
        )
        .limit(100)
    end
  end
end
