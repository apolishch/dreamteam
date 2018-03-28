class ChessPiece < ApplicationRecord
  belongs_to :game

  # def is_obstructed?(x, y)
  #   if (x == self.x_position) && (y == self.y_position) # If the piece is trying to be moved to it's current position
  #     false
  #   elsif y == self.y_position # If target is located horizontally, meaning on the same row as current position
  #     self.game.chess_pieces.select {|piece| (piece.y_position == y) && piece.x_position.between?(x, x_position)}.empty?
  #   elsif x == self.x_position # If target is located vertically - Same column
  #     self.game.chess_pieces.select {|piece| (piece.x_position == x) && piece.y_position.between?(y, y_position)}.empty?
  #   elsif (x - self.x_position).abs == (y-self.y_position).abs # If target is located diagonally from starting position
  #     self.game.chess_pieces.select {|piece| ((x - piece.x_position).abs == (y - piece.y_position).abs) && piece.x_position.between?(x, x_position) && piece.y_position.between?(y, y_position)}.empty?
  #   else
  #     false
  #   end
  # end

  def is_obstructed?(x, y)
    if (x == self.x_position) && (y == self.y_position) # If the piece is trying to be moved to it's current position
      puts "the piece is trying to be moved to it's current position"
      true
    elsif (y == self.y_position) && (self.game.chess_pieces.select {|piece| !(piece.y_position == y) && !piece.x_position.between?(x, x_position)}.empty?)   # If target is located horizontally, meaning on the same row as current position
      puts "target is located horizontally"
      true
    elsif (x == self.x_position) && (self.game.chess_pieces.select {|piece| !(piece.x_position == x) && !piece.y_position.between?(y, y_position)}.empty?) # If target is located vertically - Same column
      puts "target is located vertically"
      true
    elsif ((x - self.x_position).abs == (y - self.y_position).abs) && (!self.game.chess_pieces.select {|piece| ((x - piece.x_position).abs == (y - piece.y_position).abs) && piece.x_position.between?(x, x_position) && piece.y_position.between?(y, y_position)}.empty?) # If target is located diagonally from starting position
      puts "target is located diagonally"
      true
    else
      false
    end
  end

end
