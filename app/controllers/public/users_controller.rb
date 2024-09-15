class Public::UsersController < ApplicationController
  
   
  def index
    @user = current_user
    @users = User.all || []
    @posts = Post.all
    @post = Post.new
    
  end

  def show
   if params[:id] == "sign_out"
    # ログアウト処理を行う
    sign_out(current_user)
    redirect_to root_path, notice: "ログアウトしました"
  else
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end
  end

  def edit
    @user = User.find(params[:id])
     redirect_to user_path(current_user) if current_user != @user
  end

  def update
    @user = User.find(params[:id])
    redirect_to edit_user_path(current_user) if current_user != @user
    
    if @user.update(user_params)
    flash[:notice] = "更新が完了しました"
      redirect_to user_path(@user.id)
    else
      render :edit

    end
  end
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
