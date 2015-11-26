class CreatePointsUsers < ActiveRecord::Migration
      def change
            create_table :points_users do |t|

                  t.references :point, index: true
                  t.references :user, index: true

                  t.timestamps null: false
            end
      end
end
