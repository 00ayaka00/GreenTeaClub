class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post =  Post.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to "/users/#{params[:id]}"
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
