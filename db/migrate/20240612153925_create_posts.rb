class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :caption
      t.string :image
      t.string :shop_name

      t.timestamps
    end
  end
end
