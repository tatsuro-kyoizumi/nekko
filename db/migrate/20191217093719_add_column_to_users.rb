class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_address, :string
    add_column :users, :user_longitude, :float
    add_column :users, :user_latitude, :float
  end
end
