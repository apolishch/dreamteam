class Pawn < ChessPiece
  belongs_to :game

  def valid_direction(color)
    if (color == 'white') && (y > self.y_position)
      true
    elsif (color == 'black') && (y < self.y_position)
      true
    else
      false
    end
  end

  def first_move?
    if (self.color == 'black') && (self.y_position == 1) && (self.promotable == false)
      true
    elsif (self.color == 'white') && (self.y_position == 6) && (self.promotable == false)
      true
    else
      false
    end
  end

  def diagonal_move(x, y)
    if (x - self.x_position).abs == 1 && (y - self.y_position).abs == 1
      true
    else
      false
  end

  def en_passant?(x, y)
    if (self.color == 'black') && (self.y_position == 4) && (self.diagonal_move(x, y) == true) && (@game[y - 1][self.x_position].color == true) # when moving right behind opponent pawn
      true
    elsif (self.color == 'white') && (self.y_position == 3) && (self.diagonal_move(x, y) == true) && (@game[y + 1][self.x_position].color == false) # when moving right behind opponent pawn
      true
    else
      false
    end
  end

  def valid_move?(x, y)
    if (x == self.x_position) && (y == self.y_position) # If trying to move to same position as piece´s current position
      false
    elsif self.is_obstructed?(x, y) == true # Pawn can't be obstructed
      false
    elsif self.en_passant?(x, y) == true
      true
    elsif (self.valid_direction(color) == true) # Not allowed to move backwards
      true
    elsif ((y - self.y_position).abs == 1) && (x == self.x_position) # If piece moves 1 tile vertically and is not obstructed
      true
    elsif ((x - self.x_position).abs == 1) && ((y - self.y_position).abs == 1) # Diagonal capture where there is a piece present on target destination
      true
    elsif (self.y_position == 1) && (self.color == black) && ((y - self.y_position).abs == 2) # If target is 2 tiles away, black piece
      true
    elsif ((self.y_position == 6) && (self.color == white)) && ((y - self.y_position).abs == 2) # If target is 2 tiles away, white
      true
    else
      false
    end
  end

end
