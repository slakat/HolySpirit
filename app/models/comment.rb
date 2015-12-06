# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  commentario :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Comment < ActiveRecord::Base

      belongs_to :user
      belongs_to :point

end
