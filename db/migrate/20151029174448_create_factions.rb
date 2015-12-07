class CreateFactions < ActiveRecord::Migration
      def change
            create_table :factions do |t|

                  t.string :name
                  t.belongs_to :administrator
                  t.belongs_to :city
                  t.string :access

                  t.timestamps null: false
            end
      end
end
