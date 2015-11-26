class Picture < ActiveRecord::Base
      
      has_attached_file :pic, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ActionController::Base.helpers.asset_path('/placeholder.gif')
      validates_attachment_content_type :pic, content_type: /\Aimage\/.*\Z/

      has_many :pictures_points
      has_many :points, through: :pictures_points
end
