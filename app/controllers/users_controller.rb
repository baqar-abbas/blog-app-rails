class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    @posts = @user.recent_posts
  end

  def logout
    sign_out current_user
    redirect_to root_path
  end

end
