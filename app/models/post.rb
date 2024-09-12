class Post < ApplicationRecord
  has_many_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
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
end