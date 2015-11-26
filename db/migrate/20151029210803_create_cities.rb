class CreateCities < ActiveRecord::Migration
      def change
            create_table :cities do |t|

                  t.string :name
                  t.references :mayor

                  t.timestamps null: false
            end
      end
end
