class PicturesController < ApplicationController
      #before_action :require_current_user
      before_action :require_login, except: [:index, :show]

      def index
            @pictures = Picture.all
      end

      def show
            @picture = Picture.find(params[:id])
      end

      def new
            @picture = Picture.new
            @point = Point.find(params[:id])
      end

      def create

            @picture = Picture.new(picture_params)
            @point = Point.find_by_id(point_parameter[:point_id])
            @picture.points << @point

            respond_to do |format|
                  if @picture.save
                        format.html { redirect_to picture_path(@picture.id), notice: 'La imágen ha sido subida con éxito.'}
                        format.json { render action: 'show', status: :created, location: @picture}
                  else
                        format.html {render action: 'new', notice: 'ERRER'}
                        format.json {render json:@picture.errors, status: :unprocessable_entity}
                  end
            end
      end

      def edit
            @picture = Picture.find(params[:id])
      end

      def update
            @picture = Picture.find(params[:id])
            respond_to do |format|
                  if @picture.update(picture_params)
                        format.html { redirect_to picture_path(@picture.id), notice: 'la imagen'}
                        format.json { head :no_content}
                  else
                        format.html {render action: 'edit', notice: 'Error'}
                        format.json {render json:@picture.errors, status: :unprocessable_entity}
                  end
            end
      end

      def destroy
            @picture = Picture.find(params[:id])
            @picture.destroy
            respond_to do |format|
                  format.html {redirect_to pictures_path}
                  format.json {head :no_content}
            end
      end

      private
      def picture_params
            params.require(:picture).permit(:id, :pic)
      end
      def point_parameter
            params.require(:picture).permit(:point_id)
      end

end
