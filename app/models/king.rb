class King < ChessPiece
  belongs_to :game

  def x_move_distance(new_x_position) # Finds the distance moved in the x axis
    x_move_distance = (self.x_position - new_x_position).abs # .abs stops it from being negative
  end

  def y_move_distance(new_y_position) # Finds the distance moved in the y axis
    y_move_distance = (self.y_position - new_y_position).abs # .abs stops it from being negative
  end

  def valid_move?(new_x_position, new_y_position)
    if (x_move_distance(new_x_position) == 0 && y_move_distance(new_y_position) == 1) # Return true if vertical move distance is 1
      true
    elsif (x_move_distance(new_x_position) == 1 && y_move_distance(new_y_position) == 0) # Return true if horizontal move distance is 1
      true
    elsif (x_move_distance(new_x_position) == 1 && y_move_distance(new_y_position) == 1) # Return true if diagonal move distance is 1
      true
    else
      false
    end
  end

end