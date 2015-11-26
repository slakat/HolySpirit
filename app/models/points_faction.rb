class PointsFaction < ActiveRecord::Base
      #Tabla que permite faction.points
        belongs_to :point #, foreign_key: 'points_id'
        belongs_to :faction #, foreign_key: 'faction_id'
end
