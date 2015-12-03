# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  effect      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Item < ActiveRecord::Base
      has_many :users_items, dependent: :destroy
      has_many :users, through: :users_items


      validates :name, presence: true, uniqueness: true
end
