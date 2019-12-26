class RenamePostPictureIdToPostPictures < ActiveRecord::Migration[5.2]
  def change
    rename_column :post_pictures, :post_picture_id, :image_id
  end
end
