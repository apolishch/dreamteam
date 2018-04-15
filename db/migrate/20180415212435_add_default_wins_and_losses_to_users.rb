class AddDefaultWinsAndLossesToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :wins, 0
    change_column_default :users, :losses, 0
  end
end
