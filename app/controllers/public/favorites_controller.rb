class Public::FavoritesController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)

    if favorite.save
      post.create_notification_favorite!(current_user)
      redirect_to post_path(post), notice: 'いいねを登録しました'
    else
      redirect_to post_path(post), alert: 'いいねを登録できませんでした'
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    
    if favorite&.destroy
      redirect_to post_path(post)
    else
      redirect_to post_path(post)
    end
  end

  private

  def favorite_params
    { post_id: params[:post_id] } # 直接post_idを取得
  end

end