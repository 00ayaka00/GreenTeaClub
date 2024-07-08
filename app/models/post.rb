class Post < ApplicationRecord
  has_many_attached :image
  belongs_to :user
  
  validates :shop_name, presence: true
  validates :caption, presence: true

 def get_image
  image if image.attached?
 end
end