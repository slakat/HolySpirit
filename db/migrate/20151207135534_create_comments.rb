class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

         t.string :comment_text
         t.belongs_to :user
         t.belongs_to :point

      t.timestamps null: false
    end
  end
end
