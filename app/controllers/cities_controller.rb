class CitiesController < ApplicationController

      before_action :require_current_user, only: [ :edit, :update, :destroy]

      def index
            @cities = City.all
      end

      def show
            @city = City.find(params[:id])
      end

      def new
            @city = City.new
      end

      def create
            @city = City.new(city_params)
            respond_to do |format|
                  if @city.save
                        format.html { redirect_to city_path(@city.id), notice: 'La ciudad ha sido creada exitosamente'}
                        format.json { render action: 'show', status: :created, location: @city}
                  else
                        format.html {render action: 'new', notice: 'ERRER'}
                        format.json {render json:@city.errors, status: :unprocessable_entity}
                  end
            end
      end

      def edit
            @city = City.find(params[:id])
      end

      def update
            @city = City.find(params[:id])
            respond_to do |format|
                  if @city.update(city_params)
                        format.html { redirect_to city_path(@city.id), notice: 'la ciudad ha sido actualizada correctamente'}
                        format.json { head :no_content}
                  else
                        format.html {render action: 'edit', notice: 'ERRER'}
                        format.json {render json:@city.errors, status: :unprocessable_entity}
                  end
            end
      end

      def destroy
            @city = City.find(params[:id])
            @city.destroy
            respond_to do |format|
                  format.html {redirect_to cities_path}
                  format.json {head :no_content}
            end
      end

      def newMayor
            @userlist = User.all.map{|u| [u.username, u.id]}
            @city = City.find_by_id(params[:id])         #era @city, no @cities
            if session[:user_id].to_s == @city.mayor_id.to_s
                  puts @userlist
            end
      end

      def addMayor
            @city = City.find(params[:id])
            @city.update(city_params)

            respond_to do |format|
                  if @city.save? #FIXME: Por alguna razón la ciudad conserva su alcalde.
                        format.html { redirect_to city_path(@city.id), notice: 'la ciudad ha sido actualizada correctamente'}
                        format.json { head :no_content}
                  else
                        format.html {render action: 'edit', notice: 'Error'}
                        format.json {render json:@city.errors, status: :unprocessable_entity}
                  end
            end
      end

      private
      def city_params
            params.require(:city).permit(:name, :id, :alcalde_id, :skyline)
      end

      def require_current_user
            redirect_to root_path if session[:user_id].to_s != City.find(params[:id]).mayor_id.to_s #al parecer uno es int y el otro str.
      end

end
