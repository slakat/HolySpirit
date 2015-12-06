class FactionsController < ApplicationController

before_action :alter_on_login, only: [:join, :index, :show, :new, :create]

      def join #Une al usuario a la facción y luego redirige a la facción
            this_faction_id
            @faction.users << @user
            redirect_to faction_path(@faction)
      end

      def leave
            this_faction_id
            @facUser = FactionsUser.find_by(user_id: session[:user_id], faction_id: params[:faction_id])
            @facUser.destroy
            @newFactUser = FactionsUser.find_by( faction_id: params[:faction_id])
            #Si el que se retira es el administrador, se escoge un administrador aleatorio.
            if @newFactUser && @faction.administrator_id == session[:user_id]
                  @faction.administrator_id = @newFactUser.user_id
                  @faction.save!
            elsif !@newFactUser #TODO: Comprobar funcionamiento y que no deje errores en el resto de las cosas relacionadas a @faction.
                  @faction.destroy
            end
            redirect_to faction_path(@faction)
      end

      def faction_score
            this_faction_id
            @score = 0
            @faction.users.each do |u|
                  @score += u.score
            end
            return @score
      end

      def index
            @factions = Faction.all
            #modificado para mostrar solo las facciones de un usuario.
      end

      def show
            @faction = Faction.find(params[:id])
      end

      def new
            @faction = Faction.new
            @cities = City.all.map{|u| [u.name, u.id]}
            #@user = User.find(session[:user_id]) #current user (Users.find(current user))
            @users = User.all.map{|u| [u.name, u.id]}[session[:user_id] -1] #NOT TODO TODO FIXME
            @access = %w(public closed private) #Al editarlo aqui se debe editar en 'edit'
      end

      def create
            @faction = Faction.new(faction_params)
            @faction.administrator = @user
            respond_to do |format|
                  if @faction.save
                        #join
                        @faction.users << @user
                        format.html { redirect_to faction_path(@faction.id), notice: 'La facción ha sido creada exitosamente'}
                        format.json { render action: 'show', status: :created, location: @faction}
                  else
                        format.html {redirect_to new_faction_path, notice: 'Error al crear facción'}
                        format.json {render json:@faction.errors, status: :unprocessable_entity}
                  end
            end
      end

      def edit
            @faction = Faction.find(params[:id])
            @cities = City.all.map{|u| [u.name, u.id]}
            @users = User.all.map{|u| [u.name, u.id]}
            require_faction_admin(@faction)

            @access = %w(public closed private) #Al editarlo aqui se debe editar en 'new'
      end

      def update
            @faction = Faction.find(params[:id])
            require_faction_admin(@faction)
            respond_to do |format|
                  if @faction.update(faction_params)
                        format.html { redirect_to faction_path(@faction.id), notice: 'La facción ha sido editada exitosamente'}
                        format.json { head :no_content}

                  else
                        format.html {render action: 'edit', notice: 'ERRER'}
                        format.json {render json:@faction.errors, status: :unprocessable_entity}
                  end
            end
      end

      def destroy
            @faction = Faction.find(params[:id])
            require_faction_admin(@faction)
            @faction.destroy
            respond_to do |format|
                  format.html {redirect_to factions_path}
                  format.json {head :no_content}
            end
      end

      def count
            @faction_users = FactionsUser.all.where(faction_id: params[:id])
            return @faction_users.count
      end

      private
      def faction_params
            params.require(:faction).permit(:name, :administrator_id, :city_id, :access, :logo, :administrator)
      end
      def register_params
            params.require(:factions_user).permit(:faction_id, :user_id)
      end
      def this_faction_id
            @faction = Faction.find(params[:faction_id])
      end


end
