class CreatePictures < ActiveRecord::Migration
  def change
        create_table :pictures do |t|
             t.attachment :pic
             t.timestamps null: false
        end
  end
end
