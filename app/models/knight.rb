class Knight < ChessPiece
  belongs_to :game

  def x_move_distance(new_x_position) # Finds the distance moved in the x axis
    x_move_distance = (self.x_position - new_x_position) # .abs stops negatives
  end

  def y_move_distance(new_y_position) # Finds the distance moved in the y axis
    y_move_distance = (self.y_position - new_y_position) # .abs stops negatives
  end

  def valid_move?(new_x_position, new_y_position)
    if (x_move_distance == 2 && y_move_distance == 1)
      true
    elsif (y_move_distance == 2 && x_move_distance == 1)
      true
    else
      false
    end
  end
end

# Return == true || false
# Knight can move in L shape from starting position
# Already checked that piece has moved from starting position