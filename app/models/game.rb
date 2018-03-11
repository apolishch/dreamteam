class Game < ApplicationRecord
  belongs_to :user
  has_many :chess_pieces
  validates :game_name, presence: true
end
