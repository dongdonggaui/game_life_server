class AddDetailInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :email, :string
    add_column :users, :phone, :string
    add_column :users, :province, :string
    add_column :users, :city, :string
    add_column :users, :location, :string
    add_column :users, :gender,
    add_column :users, :description, :string
    add_column :users, :followers_count, :integer
    add_column :users, :friends_count, :integer
    add_column :users, :games_count, :integer
    add_column :users, :status_count, :integer
  end
end
