class AddSkylineToCity < ActiveRecord::Migration
  def change
        add_attachment :cities, :skyline

  end
end
