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

class Point < ActiveRecord::Base
      belongs_to :city
      belongs_to :faction


      #has_many :points_faction
      #has_many :faction, through: :points_faction

      has_many :points_users, dependent: :destroy
      has_many :users, through: :points_users

      has_many :pictures_points, dependent: :destroy
      has_many :pictures, through: :pictures_points

      validates :city, presence: true
      validates :name, presence: true
      validates :minCheckInTime, presence: true,
                numericality: true,
                format: { :with => /\A\d{1,4}?\z/ }
      validates_uniqueness_of :name
      #validates_uniqueness_of :x, :scope => [:y]

end
