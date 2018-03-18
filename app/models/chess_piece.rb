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

  def capture(x, y)

    # On the ChessPiece Model, add a check for whether the target location for movement is occupied (add a move_to! method if necessary)

    # If there is a piece occypying the location, and that piece has the opposite color, remove it from the game.

    # There are a few ways to do this:

    #     You could have a status on the pieces (e.g. onboard vs captured)
    #     you could se the x/y coordinates to nil
    #     You could point blank delete the piece from the database

    # If the piece occupying the target location shares the color of the moving piece, the move should fail.

    target_piece = ChessPiece.find_by(x_position: x, y_position: y)

    return unless target_piece.present?
    return unless piece.color != target_piece.color

    target_piece.destroy!
    self.update_attributes(x_position: x, y_position: y)

    # move_to!(x, y)
  end


end



