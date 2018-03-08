class CreateChessPieces < ActiveRecord::Migration[5.0]
  def change
    create_table :chess_pieces do |t|
      t.string :type
      t.string :icon
      t.boolean :active_piece
      t.integer :value
      t.boolean :color
      t.integer :user_id
      t.timestamps
    end
  end
end
