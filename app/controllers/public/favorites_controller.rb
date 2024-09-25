class Public::FavoritesController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)

    if favorite.save
      post.create_notification_favorite!(current_user)
      redirect_to post_path(post), notice: 'Favorite was successfully created.'
    else
      redirect_to post_path(post), alert: 'Failed to create favorite.'
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    
    if favorite&.destroy
      redirect_to post_path(post), notice: 'Favorite was successfully removed.'
    else
      redirect_to post_path(post), alert: 'Failed to remove favorite.'
    end
  end

  private

  def favorite_params
    { post_id: params[:post_id] } # 直接post_idを取得
  end

end