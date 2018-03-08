class AddFieldsToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :locations, :string
    add_column :games, :winner_id, :integer
  end
end
