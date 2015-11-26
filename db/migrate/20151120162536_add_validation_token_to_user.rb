class AddValidationTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :validation_token, :string
    add_index :users, :validation_token, unique: true
  end
end
