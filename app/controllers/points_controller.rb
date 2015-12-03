class PointsController < ApplicationController

before_action :alter_on_login, only: [:check_in, :check_out, :index]

      def check_in #hace check in en un punto
            @point = Point.find(params[:user_id])
            @point.users << @user
            @user.score += 40
            @user.save!
            redirect_to points_path
      end

      def check_out
            @point = Point.find(params[:user_id])
            @point_user = PointsUser.find_by(user_id: session[:user_id], point_id: params[:user_id])#:user_id = point_id
            @point_user.destroy
            redirect_to points_path
      end

      def index
            @points_user = PointsUser.all
            @points = Point.all
            @pictures_point = PicturesPoint.all
      end

      def show
            #:name => :string,
            # :city_id => :integer,
            #:faction_id => :integer,
            #:minCheckInTime => :integer,
            #:description => :string,
            #:x => :float,
            #:y => :float,
            @point = Point.find(params[:id])
      end

      def new
            @point = Point.new
            @cities = City.all.map{|u| [u.name, u.id]}
      end


      def map_create

            @point = Point.new()
      end

      def create
            @point = Point.new(point_params)
            mayor = City.find_by_id(point_params[:city_id]).mayor
            respond_to do |format|
                  if mayor == session[:user_id] && @point.save
                        format.html { redirect_to point_path(@point.id), notice: 'El Punto ha sido creado con exito. '}
                        format.js
                        format.json { render action: 'show', status: :created, location: @point}
                  elsif mayor == nil
                        format.html {redirect_to points_path, notice: 'Esta ciudad no tiene alcalde :('}
                        format.js
                        format.json {render json:@point.errors, status: :unprocessable_entity}
                  else
                        format.html {redirect_to points_path, notice: 'Debes ser alcalde para hacer esto'}
                        format.js
                        format.json {render json:@point.errors, status: :unprocessable_entity}
                  end
            end
      end

      def edit
            @point = Point.find(params[:id])
            @cities = City.all.map{|u| [u.name, u.id]}
      end

      def update
            @point = Point.find(params[:id])
            respond_to do |format|
                  if @point.update(point_params)
                        format.html { redirect_to point_path(@point.id), notice: 'El punto ha sido editado con éxito.'}
                        format.json { head :no_content}

                  else
                        format.html {render action: 'edit', notice: 'ERRER'}
                        format.json {render json:@point.errors, status: :unprocessable_entity}
                  end
            end
      end

      def destroy
            @point = Point.find(params[:id])
            @point.destroy
            respond_to do |format|
                  format.html {redirect_to points_path}
                  format.json {head :no_content}
            end
      end

      # points_users tabla intermedia, relación entre puntos y usuarios.
      def new_checkin
            @point_user = PointsUser.new()
            @point = [params[:id]]
            @users = User.all.map{|u| [u.name, u.id]}
            @points = Point.all.map{|u| [u.name, u.id]}
      end

      def create_checkin
            @point_user = PointsUser.new(checkin_params)
            respond_to do |format|
                  if @point_user.save!
                        format.html { redirect_to point_checkins_path(params[:id]), notice: 'Check-in exitoso' }
                        format.json { render action: 'show', status: :created, location: @point_user }
                  else
                        format.html {
                              render action: 'new'
                        }
                        format.json { render json: @point_user.errors, status: :unprocessable_entity }
                        redirect_to root_path
                  end
            end
      end

      def show_checkins
            @point = Point.find(params[:id])
            @point_users = PointsUser.all.where(point_id: params[:id])
      end

      def edit_checkin
            @point_user = PointsUser.find(params[:id])
            @point = [params[:id]]
            @users = User.all.map{|u| [u.name, u.id]}
      end

      def update_checkin
            @point_user = PointsUser.find(params[:id])

            respond_to do |format|
                  if @point_user.update(checkin_params)
                        format.html { redirect_to point_checkins_path(params[:id]), notice: 'El proyecto se actualizó exitosamente.' }
                        format.json { head :no_content }
                  else
                        format.html {
                              render action: 'edit'
                        }
                        format.json { render json: @point.errors, status: :unprocessable_entity }
                  end
            end
      end

      def index_checkin
      end

      def destroy_checkin
            @point_user = PointUser.find(params[:id_user])
            @point_user.destroy
            respond_to do |format|
                  format.html { redirect_to point_checkins_path(params[:id]) }
                  format.json { head :no_content }
            end
      end

      def count
            @point_users = PointsUser.all.where(point_id: params[:id])
            return @point_users.count
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      private
      def point_params
            params.require(:point).permit(:name, :minCheckInTime, :city_id, :description, :coordinate_id,:x,:y)
      end

      def get_mayor(city)
            User.find_by_id(city.alcalde_id)
      end

      def checkin_params
            params.require(:points_user).permit(:point_id, :user_id)
      end

end
