class Public::SearchesController < ApplicationController
  
 
  
   def search
    @range = params[:range]
    @user = current_user

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
  
end
