# == Schema Information
#
# Table name: pictures
#
#  id               :integer          not null, primary key
#  pic_file_name    :string
#  pic_content_type :string
#  pic_file_size    :integer
#  pic_updated_at   :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Picture < ActiveRecord::Base
      
      has_attached_file :pic, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ActionController::Base.helpers.asset_path('/placeholder.gif')
      validates_attachment_content_type :pic, content_type: /\Aimage\/.*\Z/

      has_many :pictures_points
      has_many :points, through: :pictures_points
end
