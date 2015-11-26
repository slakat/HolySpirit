# == Schema Information
#
# Table name: points
#
#  id             :integer          not null, primary key
#  name           :string
#  city_id        :integer
#  faction_id     :integer
#  minCheckInTime :integer
#  description    :string
#  x              :float
#  y              :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class PointTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
