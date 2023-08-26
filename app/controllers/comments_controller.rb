class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    Rails.logger.debug(params.inspect)
    @post = Post.find(params[:post_id])
    @comment = @current_user.comments.new(comment_params)
    @comment.post = @post

    if @comment.save
      redirect_to user_post_path(user_id: @current_user.id, id: @post.id),
                  notice: 'Comment has been added successfully.'
    else
      render :new
    end
  end

  private

  def comment_params
    params.permit(:Text)
  end
end
