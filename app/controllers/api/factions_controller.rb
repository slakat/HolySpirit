class Api::FactionsController < ApplicationController

before_action :alter_on_login, only: [ :index, :show, :new, :create, :destroy, :join_closed]
before_action :require_login
before_action :require_open_for_admin, only: [:new, :create]
before_action :prevent_join, only: [:join, :join_public, :join_private]


      def join_public
            this_faction_id
            if @faction.access = "public"
                  @faction.users << @user
                  redirect_to faction_path(@faction)
            end
      end

      def join_private  #require confirmación
            this_faction_id
            if @faction.access = "private"
                  @faction.users << @user
                  @factions_user = FactionsUser.last
                  @factions_user.waiting_approval = 1
                  redirect_to faction_path(@faction)
            end
      end

      def join_closed #require invitación y confirmación
            @faction = Faction.find(@user.administrated_faction_id)
            if @faction.access = "closed"
                  @user = User.find(params[:user_id])
                  @faction.users << @user
                  @factions_user = FactionsUser.last
                  @factions_user.waiting_approval = 1
                  @factions_user.invited = 1
                  @factions_user.save!
                  redirect_to users_path
            end
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
            elsif !@newFactUser
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
            render json: @factions

      end

      def show
            @faction = Faction.find(params[:id])
            render json: @faction, include: ['factions_users', 'administrator']

      end

      def new
            @faction = Faction.new
            @cities = City.all.map{|u| [u.name, u.id]}
            @access = %w(public private closed) #Al editarlo aqui se debe editar en 'edit'
      end

      def create
            @faction = Faction.new(faction_params)
            #previene creación de facciones por administradores de otras.
                  @faction.administrator = @user
                  respond_to do |format|
                        if @faction.save
                              @user.administrated_faction_id = @faction.id
                              @user.save!
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
            @users = @faction.users.map{|u| [u.name, u.id]}
            require_faction_admin(@faction)

            @access = %w(public private closed) #Al editarlo aqui se debe editar en 'new'
      end

      def update
            @faction = Faction.find(params[:id])
            require_faction_admin(@faction)
            respond_to do |format|
                  if @faction.update(faction_params)
                        format.html { redirect_to faction_path(@faction.id), notice: 'La facción ha sido editada exitosamente'}
                        format.json { head :no_content}

                  else
                        format.html {render action: 'edit', notice: 'Error al editar la facción'}
                        format.json {render json:@faction.errors, status: :unprocessable_entity}
                  end
            end
      end

      def destroy
            @faction = Faction.find(params[:id])
            require_faction_admin(@faction)
            @faction.destroy
            @user.administrated_faction_id = nil
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

      def require_open_for_admin
            if @user.administrated_faction_id != nil && @user.administrated_city_id == nil
                  redirect_to factions_path, notice: 'Ya eres administrador de una facción, no puedes crear otra.'
            end
      end


      def prevent_join
            alter_on_login
            if @user.administrated_faction_id || @user.administrated_city_id
                  redirect_to factions_path, notice: 'No puedes unirte a esta facción porque eres administrador o alcalde.'
            end
      end

end
