class King < ChessPiece
    belongs_to :game
    
    def valid_move?(x, y, color=nil)
        super
    end
    
    def in_check?
        self.opponent_pieces.each do |piece|
            piece.valid_move?(self.x_position, self.y_position)
        end
    end
    
    def opponent_pieces
        my_color = self.color
        opponent_pieces = self.game.chess_pieces.where(color: !my_color)
        
        return opponent_pieces
    end
        
end