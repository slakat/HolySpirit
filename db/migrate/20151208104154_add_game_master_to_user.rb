class AddGameMasterToUser < ActiveRecord::Migration
  def change
        add_column :users, :gm, :integer

  end
end
