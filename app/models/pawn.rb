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
    if (x == self.x_position) && (y == self.y_position)
      false
    elsif (y - self.y_position == 1) && (x - self.x_position == 0)
      true
    elsif ((x - self.x_position).abs == 1) && ((y - self.y_position).abs == 1) && !(x, y).empty?
      true
    elsif (self.y_position == 2) && (y - self.y_position == 2)
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
