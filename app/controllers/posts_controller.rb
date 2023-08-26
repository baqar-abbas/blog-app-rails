class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    user_id = params[:user_id]
    @posts = Post.where(author_id: user_id)
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comments = Comment.where(post_id: params[:id])
  end

  def new
    @post = @current_user.posts.new
  end

  def create
    @post = @current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = 'Post has been created successfully.'
      redirect_to user_post_path(@current_user, @post)
    else
      # Log validation errors
      Rails.logger.error(@post.errors.full_messages.join(', '))
      # Log other errors if any
      Rails.logger.error(@post.errors.inspect)
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text).merge(comments_counter: 0, likes_counter: 0)
  end
end
