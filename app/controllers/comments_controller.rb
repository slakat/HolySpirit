class CommentsController < ApplicationController

before_action :require_login

before_action :alter_on_login

      def index
            @comments = Comment.all
      end

      def show
            @comment = Comment.find(params[:id])
      end

      def new

            @point = Point.first #FIXME: Developing static variable


            @comment = Comment.new
      end

      def create
            @comment = Comment.new(comment_params)
            respond_to do |format|
                  if @comment.save
                        format.html { redirect_to @comment.point, notice: 'El comentario ha sido creado exitosamente'}
                        format.json { render action: 'show', status: :created, location: @comment}
                  else
                        format.html {redirect_to @comment.point, notice: 'Error al crear el comentario. Los comentarios deben tener entre 2 y 600 caracteres.'}
                        format.json {render json:@comment.errors, status: :unprocessable_entity}
                  end
            end
      end

      def edit
            @comment = Comment.find(params[:id])
            @point = @comment.point
      end

      def update
            @comment = Comment.find(params[:id])
            respond_to do |format|
                  if @comment.update(comment_params)
                        format.html { redirect_to comment_path(@comment.id), notice: 'El comentario ha sido editado exitosamente'}
                        format.json { head :no_content}
                  else
                        format.html {render action: 'edit', notice: 'Error'}
                        format.json {render json:@comment.errors, status: :unprocessable_entity}
                  end
            end
      end

      def destroy
            @comment = Comment.find(params[:id])
            @point = @comment.point
            @comment.destroy
            respond_to do |format|
                  format.html {redirect_to @point}
                  format.json {head :no_content}
            end
      end

private
def comment_params
      params.require(:comment).permit(:comment_text, :user_id, :point_id)
end


end
