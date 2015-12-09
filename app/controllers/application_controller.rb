class ApplicationController < ActionController::Base
      # Prevent CSRF attacks by raising an exception.
      # For APIs, you may want to use :null_session instead.
      protect_from_forgery with: :exception

      #agregar metodos repetidos para ser heredados para DRY

      private
      #def faction_params
      #      params.require(:faction).permit(:name, :administrator_id, :city_id, :access)
      #end
      def register_params
            params.require(:factions_user).permit(:faction_id, :user_id)
      end
      #Altera una funcionalidad al haber un usuario, es entregado como variable.
      def alter_on_login
            if session[:user_id] != nil
                  @user = User.find(session[:user_id])
            end
      end

      def require_current_user
            redirect_to root_path if session[:user_id].to_s != params[:id] #al parecer uno es int y el otro str.
      end
      #Limita acciones a el administrador de una facción.
      def require_faction_admin(f)
            #redirect_to factions_path
            redirect_to root_path if session[:user_id].to_s != (f).administrator_id.to_s
      end

      def require_login
             if session[:user_id] == nil
                  redirect_to root_path, notice: 'Necesitas estar logueado para realizar esta acción'
            end
      end

      def require_logout
            if session[:user_id] != nil
                 redirect_to root_path, notice: 'Necesitas estar deslogueado para realizar esta acción'
          end
      end

      def city_mayor_access
            @user = User.find(session[:user_id])
            if @user.administrated_city_id == nil
                  redirect_to points_path, notice: 'No puedes editar o agregar puntos sin ser el alcalde'
            end
      end

end
