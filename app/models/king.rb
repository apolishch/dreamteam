class King < ChessPiece
    belongs_to :game
    
    def opponent_pieces
        my_color = self.color
        opponent_pieces = self.game.chess_pieces.where(color: !my_color)
        
        return opponent_pieces
    end

    def is_obstructed?(x, y)
        super
    end

    def can_castle?(x, y)
       #return false if !self.is_obstructed?(x, y)
       return false if !self.has_moved?
       return false if !self._has_rook_moved?(x, y)
        
       true
    end

    def has_moved?
        super
    end

    # converts coordinates passed in to Rook
    def _has_rook_moved?(x, y)
       rook = ChessPiece.where(:game_id => self.game_id, :x_position => x, :y_position => y ).first
       return false if rook.nil?
       return false if rook.type != "Rook"

       self.has_rook_moved?(rook)
    end

    def has_rook_moved?(rook)
        rook.has_moved?
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


    def can_escape_from_check?
      king_x = x_position
      king_y = y_position
      array = []

      (-1..1).to_a.each do |x|
        (-1..1).to_a.each do |y|
          array << [x, y]
        end
      end

      return true if !game.is_in_check?(player)

      array.each do |touple|
        touple = increment_x, increment_y
        if valid_move?(king_x + increment_x, king_y + increment_y)
          true
        else
          false
        end
      end
    end
end

