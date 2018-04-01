class ChessPiece < ApplicationRecord
  belongs_to :game

  
  def valid_move?(x, y, color=nil)
    if !(self.moving_on_board?(x, y))
      return false
    elsif self.is_obstructed?(x, y)
      return false
    # elsif self.same_color?(color)
    #   binding.pry
    #   return false
    else
      true
    end
  end
    
  def is_obstructed?(x, y)
    x_sorted_array = [x, x_position].sort
    y_sorted_array = [y, y_position].sort
    if (x == self.x_position) && (y == self.y_position) # If the piece is trying to be moved to it's current position
      false
    elsif y == self.y_position # If target is located vertically, meaning on the same column as current position
      
      !self.game.chess_pieces.select {|piece| (piece.y_position == y) && piece.x_position.between?(x_sorted_array[0], x_sorted_array[1])}.empty?
    elsif x == self.x_position # If target is located horizontally - Same row
      
      !self.game.chess_pieces.select {|piece| (piece.x_position == x) && piece.y_position.between?(y_sorted_array[0], y_sorted_array[1])}.empty?
    elsif (x - self.x_position).abs == (y-self.y_position).abs # If target is located diagonally from starting position
      
      whatever = self.game.chess_pieces.select do |piece|
        
      next false if piece == self
      ((x - piece.x_position).abs == (y - piece.y_position).abs) && piece.x_position.between?(x_sorted_array[0], x_sorted_array[1]) && piece.y_position.between?(y_sorted_array[0], y_sorted_array[1])
      end
      
      !whatever.empty?
    else
      false
    end
  end


  def capture(x, y)
    target_piece = ChessPiece.find_by(x_position: x, y_position: y) # Find opponent piece

    return unless target_piece.present? # Return nothing unless the opponent piece is present
    return unless self.color != target_piece.color # Return nothing unless the opponent piece is a different color

    target_piece.destroy! # Remove opponent piece from board
    self.update_attributes(x_position: x, y_position: y) # Update position of current piece to former opponent piece position
  end


  def same_color?(color)
    color == self.color
  end
    
  def moving_on_board?(x, y)
    x.between?(0, 7) && y.between?(0, 7)
  end

  def can_threatening_piece_be_captured?
    kings_heroes = game.chess_pieces.where(color: !color)
    kings_heroes.each do |hero|
      if hero.valid_move?(x_position, y_position)
        return true
      end
    end
    false
  end
  
end

