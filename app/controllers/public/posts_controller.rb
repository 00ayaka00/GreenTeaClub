class Public::PostsController < ApplicationController


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿が完了しました"
      redirect_to posts_path
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
      unless current_user == @post.user
       flash[:alert] = "この投稿を編集する権限がありません"
       redirect_to user_path(current_user)
      end

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

 def ranking
    @posts = Post.joins(:user)
                 .select('posts.*, users.name AS user_name, COUNT(favorites.id) AS favorites_count')
                 .left_joins(:favorites)
                 .group('posts.id')
                 .order('favorites_count DESC')
                 .page(params[:page])
    @page = (params[:page] || 1).to_i
  end

  private

  def post_params
    params.require(:post).permit(:shop_name, :image, :caption)
  end
end
