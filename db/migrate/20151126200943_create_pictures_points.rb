class CreatePicturesPoints < ActiveRecord::Migration
      def change
            create_table :pictures_points do |t|

                  t.references :picture, index: true
                  t.references :point, index: true

                  t.timestamps null: false
            end
      end
end
