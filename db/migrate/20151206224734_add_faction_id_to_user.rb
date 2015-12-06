class AddFactionIdToUser < ActiveRecord::Migration
  def change
        add_reference :users, :administrated_faction

  end
end
