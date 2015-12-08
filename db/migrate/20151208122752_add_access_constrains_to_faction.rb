class AddAccessConstrainsToFaction < ActiveRecord::Migration
  def change
        add_column :factions_users, :waiting_approval, :string
        add_column :factions_users, :invited, :string
  end
end
