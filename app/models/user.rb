class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_one_attached :profile_image
  
   validates :email, presence: true
   validates :name, presence: true
   validates :name, length: { in: 2..20 }
   validates :introduction, length: { maximum: 50 }
   
  
   def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/tea-2975184_1280.webp')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.webp', content_type: 'image/webp')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
 # def get_profile_image(width, height)
 # return nil unless profile_image.attached?
 # profile_image.variant(resize_to_limit: [width, height]).processed
 # end
end 