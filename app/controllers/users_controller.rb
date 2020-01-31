class UsersController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def index
    @users = User.all
    @user = current_user
    @post = Post.new
    @post.post_pictures.build
    @posts = Post.all
    #@users = User.where(id: params[:id])
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def show
    @user = User.find_by(id: params[:id])
    @post = Post.new
    @post.post_pictures.build
    #@posts = Post.where(user_id: current_user.id)
    @posts = Post.where(user_id: @user.id).order(created_at: :desc).page(params[:page])
    @post_comment = PostComment.new
    @favorites = Favorite.where(user_id: @user.id)
    # @post_comments = PostComment.page(params[:page]).per(2)
    @followings = @user.following.all
    @following_posts = Post.where(user_id: @followings)
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    # @q = Post.ransack(params[:q])
    # @posts = @q.result(distinct: true)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render("users/edit")
    end
  end

  def destroy
  end

  def chat
    @user = User.find_by(id: current_user.id)
    @users =  @user.following.all

     # conversationsが存在していればそれを代入、なければ空で返す
     session[:conversations] ||= []

     # フォローしているユーザーを取得
     @users =  @user.following.all

     # N+1問題を避けながら、conversationsを探す
     @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])

  end

  def search_posts
    @user = User.find_by(id: current_user.id)
    @posts = Post.within_box(3, current_user.latitude, current_user.longitude).where.not(user_id: current_user.id).order(created_at: :desc)
  end

  def search_users
    @users = User.within_box(3, current_user.latitude, current_user.longitude).where.not(id: current_user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :user_address, :longitude, :latitude, posts_attributes: [:id, :caption, :post_image, :address, :longitude, :latitude, :tag_list, post_pictures_attributes: [:id, :image]])
  end

end
