class HomeController < ApplicationController

      before_action :city_mayor_access, only: [:map]

  def index
        dev
  end

def map
end

  def map_modal
    @cities = City.all.map{|u| [u.name, u.id]}
    @point =  Point.new
    @points = Point.all.map{|u| [u.name, u.id]}
  end

 private
 def dev
       @users = User.all.each do |u|
             u.validation_token = nil
             u.save
      end
      # @user = User.first
      # @user.validation_token = nil
      # @user.save!
end


end
