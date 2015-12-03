# == Schema Information
#
# Table name: users_items
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UsersItem < ActiveRecord::Base
        belongs_to :item
        belongs_to :user
end
