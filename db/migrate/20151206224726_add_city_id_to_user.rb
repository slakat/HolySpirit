class AddCityIdToUser < ActiveRecord::Migration
  def change
        add_reference :users, :administrated_city
  end
end
