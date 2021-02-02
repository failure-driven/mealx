module Types
  class Location < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :address, String, null: true
    field :latitude, String, null: true
    field :longitude, String, null: true
    field :menu_text, String, null: true
  end
end
