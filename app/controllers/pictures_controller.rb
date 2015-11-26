class PicturesController < ApplicationController
      #before_action :require_current_user

      def index
            @pictures = Picture.all
      end

      def show
            @picture = Picture.find(params[:id])
      end

      def new
            @picture = Picture.new
      end

      def create
            @picture = Picture.new(picture_params)
            respond_to do |format|
                  if @picture.save
                        format.html { redirect_to picture_path(@picture.id), notice: 'La ciudad ha sido creada exitosamente'}
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
                        format.html { redirect_to picture_path(@picture.id), notice: 'la ciudad ha sido actualizada correctamente'}
                        format.json { head :no_content}
                  else
                        format.html {render action: 'edit', notice: 'ERRER'}
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
            params.require(:picture).permit(:id)
      end
end
