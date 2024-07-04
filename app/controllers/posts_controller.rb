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
   
    @posts = Post.all
   
  end

  def show
    @post =  Post.find(params[:id])
  end

  def edit
  end
  
  private

  def post_params
    params.require(:post).permit(:shop_name, :image, :caption)
  end
end
