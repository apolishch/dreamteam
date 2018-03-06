class AddFieldsToChessPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :chess_pieces, :game_id, :integer
    add_column :chess_pieces, :x_position, :integer
    add_column :chess_pieces, :y_position, :integer
    add_column :chess_pieces, :checked, :boolean
    add_column :chess_pieces, :promotable, :boolean
  end
end
