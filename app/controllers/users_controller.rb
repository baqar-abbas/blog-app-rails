class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    @posts = @user.recent_posts
  end

  # def destroy
  #   Rails.logger.debug("Destroy action reached!")

  #   # Sign out the user
  #   # sign_out(current_user)

  #   # Redirect to the root path or another appropriate path after sign out
  #   # redirect_to new_user_session
  #   sign_out current_user
  #   redirect_to root_path
  # end

  def logout
    sign_out current_user
    redirect_to root_path
  end

end
