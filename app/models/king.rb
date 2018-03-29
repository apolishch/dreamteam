class King < ChessPiece
    belongs_to :game
    
    def opponent_pieces
        my_color = self.color
        opponent_pieces = self.game.chess_pieces.where(color: !my_color)
        
        return opponent_pieces
    end
    
    def pieces_causing_check
        pieces_causing_check = []
        self.opponent_pieces.each do |piece|
            if piece.valid_move?(self.x_position, self.y_position, self.color)
                pieces_causing_check << piece
            end
        end
        return pieces_causing_check
    end
    
    def in_check?
       if (self.pieces_causing_check).empty?
           false
       else
           true
       end
    end
        
    def x_move_distance(new_x_position) # Finds the distance moved in the x axis
      x_move_distance = (self.x_position - new_x_position).abs # .abs stops it from being negative
    end

    def y_move_distance(new_y_position) # Finds the distance moved in the y axis
      y_move_distance = (self.y_position - new_y_position).abs # .abs stops it from being negative
    end

    def valid_move?(new_x_position, new_y_position, color=nil)
      if super
          true
      elsif (x_move_distance(new_x_position) == 0 && y_move_distance(new_y_position) == 1) # Return true if vertical move distance is 1
        true
      elsif (x_move_distance(new_x_position) == 1 && y_move_distance(new_y_position) == 0) # Return true if horizontal move distance is 1
        true
      elsif (x_move_distance(new_x_position) == 1 && y_move_distance(new_y_position) == 1) # Return true if diagonal move distance is 1
        true
      else
        false
      end
    end

  def checkmate?
  # def checkmate?(color)
    # checked_king = pieces.find_by(type: 'King', color: color)

    # make sure color is in check and get @piece_causing_check
    return false unless in_check?

    # # see if another piece can capture checking piece
    # return false if @piece_causing_check.can_be_captured?

    # # see if king can get himself out of check
    # return false if checked_king.can_move_out_of_check?

    # # # see if another piece can block check
    # return false if @piece_causing_check.can_be_blocked?(checked_king)

    # true
  end

  def can_escape_from_check?
    original_x = x_position
    original_y = y_position
    can_escape = false
    ((x_position - 1)..(x_position + 1)).each do |x|
      ((y_position - 1)..(y_position + 1)).each do |y|
        update_attributes(x_position: x, y_position: y) if valid_move?(x, y)
        can_escape = true unless in_check?
        update_attributes(x_position: original_x, y_position: original_y)
      end
    end
    can_escape
  end

end

