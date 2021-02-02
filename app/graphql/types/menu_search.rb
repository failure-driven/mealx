module Types
  class MenuSearch < Types::BaseObject
    field :record_count, Integer, null: false
    field :locations, [Types::Location], null: false
  end
end
