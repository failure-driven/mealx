class Location < ApplicationRecord
  has_many :location_meals

  include PgSearch::Model

  pg_search_scope(
    :search_by_menu,
    against: [:menu_text],
    using: {
      tsearch: { prefix: true },
    },
  )
end
