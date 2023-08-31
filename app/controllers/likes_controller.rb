class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post: @post)

    if @like.save
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id), notice: 'Post liked successfully.'
    else
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id), alert: 'Failed to like the post.'
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @post = @like.post

    if @like.destroy
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id), notice: 'Post unliked successfully.'
    else
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id), alert: 'Failed to unlike the post.'
    end
  end
end
