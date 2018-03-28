class King < ChessPiece
    belongs_to :game
    
    def valid_move?(x, y, color=nil)
        super
    end
    
    def opponent_pieces
        my_color = self.color
        opponent_pieces = self.game.chess_pieces.where(color: !my_color)
        
        return opponent_pieces
    end
    
    def pieces_causing_check
        pieces_causing_check = []
        self.opponent_pieces.each do |piece|
            if piece.valid_move?(self.x_position, self.y_position)
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
        
end