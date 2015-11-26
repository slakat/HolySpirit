class CreatePoints < ActiveRecord::Migration
      def change
            create_table :points do |t|

                  t.string :name
                  t.references :city
                  t.references :faction
                  t.integer :minCheckInTime
                  t.string :description
                  t.float :x
                  t.float :y
                  
                  t.timestamps null: false
            end
      end
end
