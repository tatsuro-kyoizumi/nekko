class PostsController < ApplicationController

def new
  @post = Post.new
  @post.post_pictures.build
end

def create
  @post = Post.new(post_params)
  @post.user_id = current_user.id
  @post.save
  redirect_to user_path(current_user.id)

end

def index
  # @posts = Post.all
  if params[:q]
    @posts = @q.result(distinct: true)
  else
    @posts = Post.all.order(id: "DESC")
  end
end

def show
  @post = Post.find_by(id: params[:id])
end

def edit
  @post = Post.find_by(id: params[:id])
  @user = @post.user_id
end

def update
  @user = User.find_by(id: params[:id])
  @post = Post.find_by(id: params[:id])
  if @post.update(post_params)
    redirect_to user_path(@user.id)
  else
    render 'edit'
  end
end

private
  def post_params
    params.require(:post).permit(:caption, :post_image, :address, :longitude, :latitude, :user_id, :tag_list, post_pictures_attributes: [:id, :image])
  end
end
