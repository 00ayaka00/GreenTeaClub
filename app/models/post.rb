class Post < ApplicationRecord
  has_many_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  validates :shop_name, presence: true
  validates :caption, presence: true
  

 def get_image
  image if image.attached?
 end
 
  def favorited_by?(user)
    return false unless user
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("shop_name LIKE ? OR caption LIKE ?", "#{word}", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("shop_name LIKE ? OR caption LIKE ?", "#{word}%", "#{word}%")
    elsif search == "backward_match"
      @post = Post.where("shop_name LIKE ? OR caption LIKE ?", "%#{word}", "%#{word}")
    elsif search == "partial_match"
      @post = Post.where("shop_name LIKE ? OR caption LIKE ?", "%#{word}%", "%#{word}%")
    else
      @post = Post.all
    end
  end
  
  def self.rank_by_favorites
    Post.left_joins(:favorites)
        .select('posts.*, COUNT(favorites.id) AS favorites_count')
        .group('posts.id')
        .order('favorites_count DESC')
  end
  
  def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  
 def create_notification_post_comment!(current_user, post_comment_id)
   
  temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
  temp_ids.each do |temp_id|
    Rails.logger.debug "Sending notification to user: #{temp_id['user_id']}"
    save_notification_post_comment!(current_user, post_comment_id, temp_id['user_id'])
  end
  save_notification_post_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
 end
 

  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  
end