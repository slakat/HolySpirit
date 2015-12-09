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
      require 'net/http'

      belongs_to :city
      belongs_to :faction

      #has_many :points_faction
      #has_many :faction, through: :points_faction

      has_many :comments

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

      def as_json(options={})
            {
                id:           self.id,
                name:         self.name,
                description:  self.description,
                x:            self.x,
                y:            self.y,
                checktime:    self.minCheckInTime,
                city_id:      self.city_id

            }
      end

      def self.search_places(lat,lon)
        apikey = APP_CONFIG['token_r'];
        baseUrl = "https://api.foursquare.com/v2";

        placesSearchUrl = baseUrl + '/venues/search?oauth_token=' + apikey + '&v=20151209';

        coord = lat+','+lon
        query = URI.encode(coord)
        url = placesSearchUrl + '&ll=' + query
        uri = URI.parse(url)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = false
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(uri.request_uri)
        status = JSON.parse(http.request(request).body)
      end

end
