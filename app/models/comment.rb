# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  comment_text :string
#  user_id      :integer
#  point_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Comment < ActiveRecord::Base

      belongs_to :user, class_name: 'User'
      belongs_to :point, class_name: 'Point'

      validates :comment_text, presence: true, length: { minimum: 2, maximum: 600 }

end
