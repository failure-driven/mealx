class AddTrigramIndexToLocations < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def up
    execute(
      <<~SQL,
        CREATE INDEX CONCURRENTLY trigram_index_locations_on_menu_text
          ON locations
          USING GIN (
            (COALESCE((menu_text)::text, ''::text))
            gin_trgm_ops
          );
      SQL
    )
  end

  def down
    execute(
      <<-SQL,
        DROP INDEX trigram_index_locations_on_menu_text;
      SQL
    )
  end
end
