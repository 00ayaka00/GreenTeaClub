class ChangePostImageIdToPostIdInPostComments < ActiveRecord::Migration[6.1]
  def change
     remove_column :post_comments, :post_image_id
     add_column :post_comments, :post_id, :integer
  end
end
