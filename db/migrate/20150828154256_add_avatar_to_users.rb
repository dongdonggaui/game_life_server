class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_url, :string
    change_column_default :users, :avatar_url, 'http://img-storage.qiniudn.com/15-8-29/10112867.jpg'
  end
end
