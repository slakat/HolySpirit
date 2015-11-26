# == Schema Information
#
# Table name: factions
#
#  id                :integer          not null, primary key
#  name              :string
#  administrator_id  :integer
#  city_id           :integer
#  access            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#

class Faction < ActiveRecord::Base

       belongs_to :city

       has_many :factions_users, dependent: :destroy
       has_many :users, through: :factions_users

       #has_many :points_faction
       #has_many :points, through: :points_faction

       has_many :points

       has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ActionController::Base.helpers.asset_path('/placeholder.gif')
       validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

       belongs_to :administrator, class_name: 'User'
       #Por ahora una facción tiene 1 admin.
       #esto puede cambiarse agregando un bool "is_admin" a FactionsUser o una nueva tabla intermedia

       validates :administrator, presence: true
end
