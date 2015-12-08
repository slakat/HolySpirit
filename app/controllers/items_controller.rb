class ItemsController < ApplicationController

      before_action :require_login

      def index
            @items = Item.all
            @users = User.all
            current_user
            @users_item  = UsersItem.all
      end

      def show
            @item = Item.find(params[:id])
      end

      def new
            @item = Item.new()
            @users = User.all.map{|u| [u.name, u.id]}
      end

      def create
            @item = Item.new(item_params)
            respond_to do |format|
                  if @item.save
                        format.html { redirect_to item_path(@item.id), notice: 'El Item ha sido creado exitosamente'}
                        format.json { render action: 'show', status: :created, location: @item}
                  else
                        format.html {render action: 'new', notice: 'ERRER'}
                        format.json {render json:@item.errors, status: :unprocessable_entity}
                  end
            end
      end

      def edit
            @item = Item.find(params[:id])
            @users = User.all.map{|u| [u.name, u.id]}
      end

      def update
            @item = Item.find(params[:id])
            respond_to do |format|
                  if @item.update(item_params)
                        format.html { redirect_to item_path(@item.id), notice: 'El objeto has been updated successfully'}
                        format.json { head :no_content}

                  else
                        format.html {render action: 'edit', notice: 'ERRER'}
                        format.json {render json:@item.errors, status: :unprocessable_entity}
                  end
            end
      end

      def destroy
            @item = Item.find(params[:id])
            @item.destroy
            respond_to do |format|
                  format.html {redirect_to items_path}
                  format.json {head :no_content}
            end
      end

      private
      def item_params
            params.require(:item).permit(:name, :description, :effect, :user_id)
      end

      def current_user
            @user = User.all.find(session[:user_id])
      end


end
