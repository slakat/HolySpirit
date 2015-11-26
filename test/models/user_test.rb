# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string
#  username            :string
#  score               :integer          default(0)
#  energy              :integer          default(100)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  password_digest     :string
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  email               :string
#  validation_token    :string
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
