class Public::PostsController < ApplicationController
 

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿が完了しました"
      redirect_to post_path(@post)
    else
       @user = current_user
       @posts = Post.order(created_at: :desc)
       render :new
    end
  end
  
  def index
    #@post = Post.page(params[:page])
   
    @posts = Post.order(created_at: :desc).page(params[:page]) || []
   
  end

  def show
    @post =  Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
     @post = Post.find(params[:id])
      redirect_to posts_path if current_user != @post.user
    
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to '/posts'
  end
  
  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      flash[:notice] = "更新が完了しました"
      redirect_to post_path(@post.id)
    else
      render :edit

    end
  end 
  
  private

  def post_params
    params.require(:post).permit(:shop_name, :image, :caption)
  end
end
