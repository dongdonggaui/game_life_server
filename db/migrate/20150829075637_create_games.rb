class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.date :publish_time
      t.text :game_bio
      t.string :company

      t.timestamps null: false
    end
  end
end
