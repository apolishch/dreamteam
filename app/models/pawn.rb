class Pawn < ChessPiece

  def valid_direction(color)
    if (color == white) && (y > self.y_position)
      true
    elsif (color == black) && (y < self.y_position)
      true
    else
      false
    end
  end

  def valid_move?(x, y)
    if (x == self.x_position) && (y == self.y_position) # If the piece is trying to be moved to it's current position
      false
    elsif (y - self.y_position == 1) && (x - self.x_position == 0) # If target is located vertically and the target is 1 tile away
      true
    elsif ((x - self.x_position).abs == 1) && ((y - self.y_position).abs == 1) && !(x, y).empty? # If target is located diagonally from start, but only one tile away (left or right)
      true
    elsif (self.y_position == 2) && (y - self.y_position == 2) # change y_position to 7 if black pieces => Will allow move of two vertically if standing from starting position.
      true
    else
      false
    end
  end



# Can move two tiles vertically when first move
# Can move 1 tile vertically, up 1 row if white and down 1 row when black
# Cant' move backwards from where it came.
# Can't move horizontally
# Can only capture vertically and 1 tile away
