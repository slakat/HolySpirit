class HomeController < ApplicationController
  def index
  end

  def map_modal
    @cities = City.all.map{|u| [u.name, u.id]}
  end


end
