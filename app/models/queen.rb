class Queen < ChessPiece

  belongs_to :game

  def x_move_distance(new_x_position) # Finds the distance moved in the x axis
    x_move_distance = (self.x_position - new_x_position).abs # .abs stops negatives
  end

  def y_move_distance(new_y_position) # Finds the distance moved in the y axis
    y_move_distance = (self.y_position - new_y_position).abs # .abs stops negatives
  end

  def diagonal?(x_move_distance, y_move_distance) # Checks that it is a diagonal move from original position
    x_move_distance == y_move_distance 
  end

  def valid_move?(new_x_position, new_y_position)
    super
    if diagonal?(new_x_position, new_y_position)
      true
    elsif (new_x_position == self.x_position && new_y_position != self.y_position)
      true
    elsif (new_y_position == self.y_position && new_x_position != self.x_position)
      true
    else
      false 
    end
  end

end

# Return == true || false
# Queen can move horizontally, vertically and diagonally from starting position
# Already checked that piece has moved from starting position
