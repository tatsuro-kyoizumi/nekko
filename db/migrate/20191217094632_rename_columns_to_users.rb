class RenameColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :user_longitude, :longitude
    rename_column :users, :user_latitude, :latitude
  end
end
