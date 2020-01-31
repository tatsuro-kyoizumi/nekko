class FavoritesController < ApplicationController

  def create
    user = current_user
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    # 直前のページヘ戻るため、redirect_backに修正
    redirect_back(fallback_location: root_path)
    # redirect_to users_path(user)
  end

  def destroy
    user = current_user
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
    # redirect_to users_path(user)
  end
end
