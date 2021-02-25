class AddTsearchIndexToLocations < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def up
    execute(
      <<~SQL,
        CREATE INDEX CONCURRENTLY tsearch_index_locations_on_menu_text
          ON locations
          USING GIN (
            to_tsvector('simple'::regconfig, COALESCE((menu_text)::text, ''::text))
          );
      SQL
    )
  end

  def down
    execute(
      <<-SQL,
        DROP INDEX tsearch_index_locations_on_menu_text;
      SQL
    )
  end
end
