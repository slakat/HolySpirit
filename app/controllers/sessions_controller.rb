class SessionsController < ApplicationController

      #referencia: http://nycda.com/blog/basic-user-authentication-model-in-rails-4/
      def new
            if(session[:user_id] != nil) #Evita el intento de login cuando ya hay login.
                  redirect_to root_path
                  flash[:notice] = "Ya has iniciado sesión."
                  return
            end
      end

      def create
            user = User.authenticate(params[:username], params[:password_digest])
            if(user.nil?)
                  @title = 'Sign in'
                  flash.now[:error] = 'Error al inicio de sesión. Verifique que su username y password sean correctos.'
                  #vista a la que se redirige luego de crear la sesión
            else
                  sign_in user
                  redirect_to user_path(user[:id]), notice: 'Sesión iniciada exitosamente'
            end
      end

      def destroy
            reset_session
            flash[:notice] = "Has cerrado tu sesión."
            redirect_to root_url
      end

      private
      def sign_in(user)
            session[:user_id] = user.id
      end
end
