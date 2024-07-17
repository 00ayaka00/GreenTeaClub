class Public::PhotosController < ApplicationController
  def index
  end

  def show
  end

  def new
    @photo = Photo.new
  end
  
  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    @photo.save
    redirect_to photos_path
  end
  
  private

  def photo_params
    params.require(:photo).permit(:shop_name, :image, :caption)
  end
  
end
