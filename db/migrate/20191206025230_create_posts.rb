class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :post_image_id
      t.text :caption
      t.string :address
      t.float :longitude
      t.float :latitude
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
