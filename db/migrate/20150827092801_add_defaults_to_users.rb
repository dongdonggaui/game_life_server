class AddDefaultsToUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :gender, 'm'
  end
end
