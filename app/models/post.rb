class Post < ApplicationRecord
  has_many_attached :image
  belongs_to :user

 def get_image
  image if image.attached?
 end
end