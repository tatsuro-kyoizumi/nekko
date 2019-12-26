class PostCommentsController < ApplicationController

  def create
    #user = current_user

    post = Post.find(params[:post_id])
    post_comment = current_user.post_comments.new(post_comment_params)
    post_comment.post_id = post.id
    post_comment.save
    redirect_back(fallback_location: user_path(post.user.id))
    #redirect_to user_path(post.user.id)
  end

  def destroy
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:user_id, :post_id, :comment)
  end
end
