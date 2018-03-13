class ChessPiece < ApplicationRecord
  belongs_to :game

  def is_obstructed?(x, y)
    if (x == self.x_position) && (y == self.y_position) # If the piece is trying to be moved to it's current position
      false
    elsif y == self.y_position # If target is located vertically, meaning on the same column as current position
      self.game.chess_pieces.select {|piece| (piece.y_position == y) && piece.x_position.between?(x, x_position)}.empty?
    elsif x == self.x_position # If target is located horizontally - Same row
      self.game.chess_pieces.select {|piece| (piece.x_position == x) && piece.y_position.between?(y, y_position)}.empty?
    elsif (x - self.x_position).abs == (y-self.y_position).abs # If target is located diagonally from starting position
      self.game.chess_pieces.select {|piece| ((x - piece.x_position).abs == (y - piece.y_position).abs) && piece.x_position.between?(x, x_position) && piece.y_position.between?(y, y_position)}.empty?
    else
      false
    end
  end

end


#
