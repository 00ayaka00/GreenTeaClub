class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :caption
      t.string :image
      t.string :shop_name

      t.timestamps
    end
  end
end
