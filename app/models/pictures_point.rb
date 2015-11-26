# == Schema Information
#
# Table name: pictures_points
#
#  id         :integer          not null, primary key
#  picture_id :integer
#  point_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PicturesPoint < ActiveRecord::Base
  belongs_to :picture
  belongs_to :point

end
