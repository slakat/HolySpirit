# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string
#  mayor_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ActiveRecord::Base
 has_many :factions
 has_many :points
 belongs_to :mayor, class_name: 'User'

 has_attached_file :skyline, styles: { medium: "2000x500>", thumb: "400x200>" }, default_url: ActionController::Base.helpers.asset_path('/placeholder.gif')
 validates_attachment_content_type :skyline, content_type: /\Aimage\/.*\Z/


 validates :name, presence: true, uniqueness: true
 validates :mayor, presence: true, uniqueness: true
end
