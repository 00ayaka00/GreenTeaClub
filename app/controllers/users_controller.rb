class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all || []
    @posts = Post.all
    @post = Post.new
    
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post =  Post.find(params[:id])
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


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
