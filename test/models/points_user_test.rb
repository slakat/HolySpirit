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

require 'test_helper'

class PointsUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
