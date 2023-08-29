class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    params[:user_id]
    @posts = Post.where(author_id: @user.id).includes(:comments)
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @user = User.find(params[:user_id])
    @comments = @post.comments
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
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text).merge(comments_counter: 0, likes_counter: 0)
  end
end
