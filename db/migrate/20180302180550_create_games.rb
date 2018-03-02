class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :game_name
      t.integer :user_id
      t.integer :opponent_id
      t.integer :game_id
      t.timestamps
    end
    add_index :games, :game_id
  end
end
