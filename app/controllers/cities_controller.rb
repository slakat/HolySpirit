class CitiesController < ApplicationController

      before_action :alter_on_login, only: [:show, :create]
      before_action :requiere_city_mayor, only: [:edit, :update, :destroy]
      before_action :current_city, only: [:show, :edit, :update, :destroy, :new_mayor, :add_mayor]
      def index
            @cities = City.all
            @users = User.all
      end

      def show
            @users = User.all
            current_city
      end

      def new
            @city = City.new
      end

      def create
            @city = City.new(city_params)
            @city.mayor = User.find_by_id(session[:user_id]) #TODO: Temporary, solo un sysadmin puede hacerlo.
            respond_to do |format|
                  if @city.save!
                        @user.administrated_city_id = @city.id
                        @user.save!
                        format.html { redirect_to city_path(@city.id), notice: 'La ciudad ha sido creada exitosamente'}
                        format.json { render action: 'show', status: :created, location: @city}
                  else
                        format.html {render action: 'new', notice: 'Error'}
                        format.json {render json:@city.errors, status: :unprocessable_entity}
                  end
            end
      end

      def edit
      end

      def update
            respond_to do |format|
                  if @city.update(city_params)
                        format.html { redirect_to city_path(@city.id), notice: 'la ciudad ha sido actualizada correctamente'}
                        format.json { head :no_content}
                  else
                        format.html {render action: 'edit', notice: 'Error'}
                        format.json {render json:@city.errors, status: :unprocessable_entity}
                  end
            end
      end

      def destroy
            @city.destroy
            respond_to do |format|
                  format.html {redirect_to cities_path}
                  format.json {head :no_content}
            end
      end

      def new_mayor
            @userlist = User.all.map{|u| [u.username, u.id]}
            if session[:user_id].to_s == @city.mayor_id.to_s
                  puts @userlist
            end
      end

      def add_mayor
            @city.update(city_params)
            respond_to do |format|
                  if @city.save?
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
            params.require(:city).permit(:name, :alcalde_id, :skyline)
      end

      def require_current_user
            redirect_to root_path if session[:user_id].to_s != City.find(params[:id]).mayor_id.to_s #al parecer uno es int y el otro str.
      end
      def current_city
            @city = City.find(params[:id])
      end
      def requiere_city_mayor
            current_city
            alter_on_login
            if @city.mayor != @user
                  redirect_to cities_path, notice: 'No puedes editar esta ciudad'
            end
      end

end
