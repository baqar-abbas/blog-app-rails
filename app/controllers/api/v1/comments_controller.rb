class Api::V1::CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    load_and_authorize_resource
  
    def index
      comments = Comment.where(author_id: params[:user_id])
      render json: comments, status: :ok
    end
  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.new(Text: comment_params[:Text], user_id: current_user.id, post_id: @post.id)
      if @comment.save
        render json: @comment
      else
        render error: { error: 'Unable to create comments' }, status: 400
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:Text)
    end
  end