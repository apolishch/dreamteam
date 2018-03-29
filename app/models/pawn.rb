class Pawn < ChessPiece
  belongs_to :game

  def valid_direction?(x, y)
    if (self.color == true) && (y < self.y_position)
      true
    elsif (self.color == false) && (y > self.y_position)
      true
    else
      false
    end
  end

  def first_move?(x, y)
    if (self.color == false) && (self.y_position == 1) && (self.promotable == false) && ((y - self.y_position).abs == 2)
      true
    elsif (self.color == true) && (self.y_position == 6) && (self.promotable == false) && ((y - self.y_position).abs == 2)
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
  end

  def en_passant?(x, y)
    if (self.color == false) && (self.y_position == 4) && (self.diagonal_move(x, y) == true) && (@game[y - 1][self.x_position].color == true) # when moving right behind opponent pawn
      true
    elsif (self.color == true) && (self.y_position == 3) && (self.diagonal_move(x, y) == true) && (@game[y + 1][self.x_position].color == false) # when moving right behind opponent pawn
      true
    else
      false
    end
  end

  def valid_move?(x, y)
    if (x == self.x_position) && (y == self.y_position) # If trying to move to same position as piece´s current position
      false
    # elsif self.is_obstructed?(x, y) == true # Pawn can't be obstructed
    #   false
    elsif !self.valid_direction?(x, y) # Not allowed to move backwards
      false
    elsif ((y - self.y_position).abs == 1) && (x == self.x_position) # If piece moves 1 tile vertically
      true
    elsif self.diagonal_move(x, y) # Diagonal capture where there is a piece present on target destination
      true
    elsif (self.valid_direction?(x, y)) && (self.first_move?(x, y))
      true
    elsif self.en_passant?(x, y)
      true
    else
      false
    end
  end

end
