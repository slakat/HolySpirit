class CreateUsersItems < ActiveRecord::Migration
      def change
            create_table :users_items do |t|

                  t.references :item, index: true
                  t.references :user, index: true
                  
                  t.timestamps null: false
            end
      end
end
