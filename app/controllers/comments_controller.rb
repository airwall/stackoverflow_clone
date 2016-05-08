class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable, only: :create

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      render json: {
        commentable: @commentable.class.name.underscore,
        commentable_id: @commentable.id
      }
    else
      render json: {errors: @comment.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def model_klass
    commentable_name.classify.constantize
  end

  def commentable_name
    params[:commentable]
  end

  def set_commentable
    @commentable = model_klass.find(params["#{commentable_name.singularize}_id"])
  end
end
