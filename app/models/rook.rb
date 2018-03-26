class Rook < ChessPiece

  belongs_to :game

  def valid_move?(new_x_position, new_y_position)
    if (new_x_position == self.x_position && new_y_position != self.y_position)
      true
    elsif (new_y_position == self.y_position && new_x_position != self.x_position)
      true
    else
      false
    end
    super
  end
end

# Return == true || false
# Not working out if it is obstructed, only if it is valid as a principle of chess movements

# Piece must move off from its starting point -- already worked out in chess_piece model
# Rook can move in either y || x axis but not both in one move

