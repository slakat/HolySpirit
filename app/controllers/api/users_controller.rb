class Api::UsersController < ApplicationController

      before_action :require_current_user, only: [ :edit, :update, :destroy] #, :get_item, :use_item] falla el require por el id de la url.
      #before_action :alter_on_login, only [:get_item, :use_item]
      #http://nycda.com/blog/basic-user-authentication-model-in-rails-4/
      before_action :require_login, except: [:index, :show, :new, :create, :validate]
      before_action :require_logout, only: [:new, :create]

      def get_item
            alter_on_login
            #if @user.energy  - 100 > 0
            @user.energy += 100
            @user.save!
            @user.items << Item.find(params[:user_id])#:user_id = id del item.
            render json: @user, status: :got_item
      end

      def use_item
            alter_on_login
            if @user.energy - 100 >= 0
                  @user.energy -= 100
                  @user.score += 10
                  @user.save!

                  @iteUser = UsersItem.find_by(user_id: session[:user_id], item_id: params[:user_id])#:user_id = item_id
                  @iteUser.destroy
                  render json: @user, status: :used_item
            else
                  render json: @user, status: :not_enough_energy
            end
      end

      def validate
            user = User.find_by(validation_token: params[:token])
            if user
                  user.update(validation_token: nil) #TODO: session imposible con validation_token != null
                  render json: @user, status: :validated
            else
                  render json: @user, [status: :wrong_link]
            end
      end

      def index
            @users = User.all
            render json: @users

      end

      def show
            @user = User.find(params[:id])
            @points_users = PointsUser.where(user_id: @user.id)
            @factions_users = FactionsUser.where(user_id: @user.id)
            @items_users = UsersItem.where(user_id: @user.id)

            render json: @user, include: ['points_users', 'factions_users', 'users_items'], status: :success

      end


      def new
            @user = User.new
      end

      def create
            @user = UserManager.create(user_params)
            respond_to do |format|
                  if @user.save
                        format.json { render :show, status: :created, location: @user }
                  else
                        format.json { render json: @user.errors, status: :unprocessable_entity }
                  end
            end
      end

      def edit
            @user = User.find(params[:id])
      end

      def update
            if @user.update(user_params)
                  render json: @user, status: :success
            else
                  render json: @user, status: :error
            end
      end

      def destroy
            @user = User.find(params[:id])
            if @user.administrated_faction_id
                  @faction = Faction.find(@user.administrated_faction_id)
                  @faction.destroy
            else
                  @user.factions.each do |faction|
                        FactionsUser.find_by(user_id: session[:user_id], faction_id: faction.id).destroy
                  end
            end
            @user.destroy
            render json: 'status: :success'
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
