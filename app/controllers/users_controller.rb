class UsersController < ApplicationController

      before_action :require_current_user, only: [ :edit, :update, :destroy] #, :get_item, :use_item] falla el require por el id de la url.
      #before_action :alter_on_login, only [:get_item, :use_item]
      #http://nycda.com/blog/basic-user-authentication-model-in-rails-4/

      before_action :require_logout, only: [:new]

      def get_item
            alter_on_login
            #if @user.energy  - 100 > 0
                  @user.energy += 100
                  @user.save!

                  @user.items << Item.find(params[:user_id])#:user_id = id del item.
                  redirect_to items_path
      end
 
      def use_item
            alter_on_login
            if @user.energy - 100 >= 0
                  @user.energy -= 100
                  @user.score += 10
                  @user.save!

                  @iteUser = UsersItem.find_by(user_id: session[:user_id], item_id: params[:user_id])#:user_id = item_id
                  @iteUser.destroy
                  redirect_to items_path
            else
                      flash[:notice] = "No tienes suficiente energía."
            end
      end

      def validate
        user = User.find_by(validation_token: params[:token])
        if user
          user.update(validation_token: nil)
          redirect_to log_in_path, notice: 'Cuenta validada exitosamente'
        else
          redirect_to root_path, alert: 'Link de validación incorrecto'
        end
      end

      def index
            @users = User.all
            faction_nesting
      end

      def show
            @user = User.find(params[:id])
            @points_users = PointsUser.where(user_id: @user.id)
            @factions_users = FactionsUser.where(user_id: @user.id)
            @items_users = UsersItem.where(user_id: @user.id)
      end

      def new
            @user = User.new
            faction_nesting #FIXME puede que ya no sea necesario por /join
      end

      def create
            # @user = User.new(user_params)
            #
            #      if @user.save
            @user = UserManager.create(user_params) #FIXME, por alguna razón no lo encuentra.

            respond_to do |format|
                  if @user.persisted?
                        format.html { redirect_to (log_in_path), notice: 'User was successfully created.' }
                        format.json { render :show, status: :created, location: @user }
                  else
                        format.html { render :new }
                        format.json { render json: @user.errors, status: :unprocessable_entity }
                  end
            end
      end

      def edit
            @user = User.find(params[:id])
      end

      def update
            @user = User.find(params[:id])
            respond_to do |format|
                  if @user.update(user_params)
                        format.html { redirect_to user_path(@user.id), notice: 'El Usuario ha sido creado correctamente'}
                        format.json { head :no_content}
                  else
                        format.html {render action: 'edit', notice: 'ERROR'}
                        format.json {render json:@user.errors, status: :unprocessable_entity}
                  end
            end
      end

      def destroy
            @user = User.find(params[:id])
            @user.factions.each do |faction|
                  if faction.administrator_id == @user.id
                        FactionsUser.find_by(user_id: session[:user_id], faction_id: faction.id).destroy
                        Faction.find(faction.id).administrator_id = User.find(faction.users.first).id
                        @class.lasdmm #FIXME: Solo modifica la variable y no lo guarda en la DB.
                        #faction.administrator_id = User.find(faction.users.first).id
                        #@mac.asdasd
                  end
            end

            @factions = Faction.all
            # @factions.each do |f|
            #       if f.administrator_id == @user.id
            #             f.leave(f)
            #       end
            # end

            @user.destroy
            respond_to do |format|
                  format.html {redirect_to log_out_path}
                  format.json {head :no_content}
            end
            #session.destroy
      end

      private
      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
            params.require(:user).permit(:name, :username, :password, :password_confirmation, :avatar, :email)
      end

      #para acciones invocadas por facciones sobre user.
      def faction_nesting
            if params[:faction_id] != nil
                  @faction = Faction.find(params[:faction_id])
            end
      end


end
