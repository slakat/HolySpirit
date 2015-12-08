module Api
  class PointsController < BaseController

    def show
      point = Point.find(params[:id])
      puts point_url(point)
      render json: point, include: 'points'
    end

    def update
      point = Point.find(params[:id])
      alter_on_login
      # This action requires to have a valid user
      if not @user || point.users.include?(@user) # if not @current_user || ngo.users.include?(@current_user)
        render nothing: true, status: :unauthorized and return
      end
      if point.update(point_params)
        render nothing: true, status: :no_content
      else
        render json: { errors: point.errors }, status: :bad_request
      end
    end

    private

    def point_params
      params.require(:point).permit(:name)
    end
  end

end
