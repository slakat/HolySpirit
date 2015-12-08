# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  name                     :string
#  username                 :string
#  score                    :integer          default(0)
#  energy                   :integer          default(100)
#  administrated_city_id    :integer
#  administrated_faction_id :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  password_digest          :string
#  avatar_file_name         :string
#  avatar_content_type      :string
#  avatar_file_size         :integer
#  avatar_updated_at        :datetime
#  email                    :string
#  validation_token         :string
#  gm                       :integer
#

class User < ActiveRecord::Base

      has_many :comments

      has_many :users_items, dependent: :destroy
      has_many :items, through: :users_items

      has_many :points_users, dependent: :destroy
      has_many :points, through: :points_users

      has_many :factions_users, dependent: :destroy
      has_many :factions, through: :factions_users

      has_one :administrated_faction, class_name: 'Faction', :foreign_key => "faction_id"

      has_one :administrated_city, class_name: 'City', :foreign_key => "city_id"

      has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ActionController::Base.helpers.asset_path('/placeholder.gif')
      validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

      validates :name, presence: true, uniqueness: true, format: { with: /[a-zA-Z0-9]/ }, length: { minimum: 4 }
      validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 18 }
      #validates :password, presence: true, length: { minimum: 4, maximum: 30 }

      validates :email, presence: true, uniqueness: true, format: /\A[a-z0-9\._+-]+@[a-z0-9\._-]+\.[a-z]{1,5}\z/

      before_create :generate_validation_token

      def self.authenticate(username, password)
            user = User.where(username: username).first
            if user && password == user.password
                  user
            else
                  nil
            end
      end
      has_secure_password


      private
      def generate_validation_token
            self.validation_token = SecureRandom.urlsafe_base64(50)
      end


end
