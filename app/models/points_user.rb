# == Schema Information
#
# Table name: points_users
#
#  id         :integer          not null, primary key
#  point_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PointsUser < ActiveRecord::Base
        belongs_to :point
        belongs_to :user
end
``
