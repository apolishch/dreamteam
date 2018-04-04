class AddGameidToMoves < ActiveRecord::Migration[5.0]
  def change
    add_column :moves, :game_id, :integer 
  end
end
