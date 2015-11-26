class CreateFactionsUsers < ActiveRecord::Migration
      def change
            create_table :factions_users do |t|

                  t.references :faction, index: true
                  t.references :user, index: true

                  t.timestamps null: false
            end
      end
end
