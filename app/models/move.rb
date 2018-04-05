class Move < ApplicationRecord
  belongs_to :game

  def piece_moved?(x_position, y_position, new_x_position, new_y_position)
    
  end

  def move_count

  end




end
