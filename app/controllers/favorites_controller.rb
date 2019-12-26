class FavoritesController < ApplicationController

  def create
    user = current_user
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to users_path(user)
  end

  def destroy
    user = current_user
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to users_path(user)
  end
end
