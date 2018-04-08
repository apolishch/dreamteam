class CreateMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.integer :game_id
      t.integer :chess_piece_id
      t.integer :count, :default => 0
      t.integer :x_position
      t.integer :y_position
      t.integer :new_x_position
      t.integer :new_y_position
    end
  end
end
