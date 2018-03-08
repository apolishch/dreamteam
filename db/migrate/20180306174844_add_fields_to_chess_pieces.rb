class AddFieldsToChessPieces < ActiveRecord::Migration[5.0]
  def change
    create_table :chess_pieces do |t|
    t.integer :game_id
    t.integer :x_position
    t.integer :y_position
    t.boolean :checked
    t.boolean :promotable
    end
  end
end
