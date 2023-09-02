class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post

    if @comment.save
      redirect_to user_post_path(user_id: @current_user.id, id: @post.id),
                  notice: 'Comment has been added successfully.'
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment # Check authorization using CanCanCan

    if @comment.destroy
      flash[:notice] = 'Comment deleted successfully.'
    else
      flash[:alert] = 'Failed to delete the comment.'
    end

    redirect_back(fallback_location: root_path)
  end


  private

  def comment_params
    params.permit(:Text)
  end
end
