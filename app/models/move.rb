class Move < ApplicationRecord
  belongs_to :game
  belongs_to :chess_piece
  accepts_nested_attributes_for :chess_piece

  def update_moves
    piece = game.chess_pieces.find([game_id])
    puts piece
    puts "Cray cray if this is working!"
  end

end
