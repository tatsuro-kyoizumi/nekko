class CreatePostPictures < ActiveRecord::Migration[5.2]
  def change
    create_table :post_pictures do |t|
      t.text :post_picture_id
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
