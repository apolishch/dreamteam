class CreateMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.integer :count
      t.timestamps
    end
  end
end
