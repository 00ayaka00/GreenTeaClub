class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
  end
  
  def index
    #@post = Post.page(params[:page])
    @posts = Post.includes(:image).all
  end

  def show
  end

  def edit
  end
  
  private

  def post_params
    params.require(:post).permit(:shop_name, :image, :caption)
  end
end
