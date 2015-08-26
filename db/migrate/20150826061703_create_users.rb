class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest

      t.timestamps null: false
      t.index :username, unique: true
    end
  end
end
