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
    favorites.exists?(user_id: user.id)
  end
end