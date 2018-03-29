class ChessPiece < ApplicationRecord
  belongs_to :game

  def is_obstructed?(x, y)
    if (x == self.x_position) && (y == self.y_position) # Checks if target is same as current position
      false
    elsif y == self.y_position # Checks if target is located horizontally from current position
      !self.game.chess_pieces.select {|piece| (piece.y_position == y) && piece.x_position.between?(x, x_position)}.empty? # Returns true if anye of the tiles in between target and current position are occupied by one or several pieces
    elsif x == self.x_position # Checks if target is located vertically from current position
      !self.game.chess_pieces.select {|piece| (piece.x_position == x) && piece.y_position.between?(y, y_position)}.empty? # Returns true if anye of the tiles in between target and current position are occupied by one or several pieces
    elsif (x - self.x_position).abs == (y-self.y_position).abs # Checks if target is located diagonally from current position
      !self.game.chess_pieces.select {|piece| ((x - piece.x_position).abs == (y - piece.y_position).abs) && piece.x_position.between?(x, x_position) && piece.y_position.between?(y, y_position)}.empty? # Returns true if anye of the tiles in between target and current position are occupied by one or several pieces
    else
      false
    end
  end
end
