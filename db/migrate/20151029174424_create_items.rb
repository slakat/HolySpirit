class CreateItems < ActiveRecord::Migration
      def change
            create_table :items do |t|

                  t.string :name
                  t.string :description
                  t.string :effect
                  t.references :user

                  t.timestamps null: false
            end
      end
end
