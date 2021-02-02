class AddMenuTextToLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :menu_text, :text
  end
end
