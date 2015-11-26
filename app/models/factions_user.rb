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

class FactionsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :faction

  validates :user_id, uniqueness: { scope: :faction_id } #validate uniqueness de dos campos.
end
