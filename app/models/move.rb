class Move < ApplicationRecord
  belongs_to :game
  belongs_to :chess_piece
end
