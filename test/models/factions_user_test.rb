# == Schema Information
#
# Table name: factions_users
#
#  id         :integer          not null, primary key
#  faction_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FactionsUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
