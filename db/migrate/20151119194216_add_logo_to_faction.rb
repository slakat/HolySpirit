class AddLogoToFaction < ActiveRecord::Migration
  def change
        add_attachment :factions, :logo
  end
end
