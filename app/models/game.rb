class Game < ApplicationRecord
  belongs_to :user
  validates :game_name, presence: true
  
  def initialize
    @black_rook_1 = Rook.new(icon: "black rook")
    @black_rook_2 = Rook.new(icon: "black rook")
    @black_knight_1 = Knight.new(icon: "black knight")
    @black_knight_2 = Knight.new(icon: "black knight")
    @black_bishop_1 = Bishop.new(icon: "black bishop")
    @black_bishop_2 = Bishop.new(icon: "black bishop")
    @black_queen = Queen.new(icon: "black queen")
    @black_king = King.new(icon: "black king")
    @black_pawn_1 = Pawn.new(icon: "black pawn")
    @black_pawn_2 = Pawn.new(icon: "black pawn")
    @black_pawn_3 = Pawn.new(icon: "black pawn")
    @black_pawn_4 = Pawn.new(icon: "black pawn")
    @black_pawn_5 = Pawn.new(icon: "black pawn")
    @black_pawn_6 = Pawn.new(icon: "black pawn")
    @black_pawn_7 = Pawn.new(icon: "black pawn")
    @black_pawn_8 = Pawn.new(icon: "black pawn")
    @white_rook_1 = Rook.new(icon: "white rook")
    @white_rook_2 = Rook.new(icon: "white rook")
    @white_knight_1 = Knight.new(icon: "white knight")
    @white_knight_2 = Knight.new(icon: "white knight")
    @white_bishop_1 = Bishop.new(icon: "white bishop")
    @white_bishop_2 = Bishop.new(icon: "white bishop")
    @white_queen = Queen.new(icon: "white queen")
    @white_king = King.new(icon: "white king")
    @white_pawn_1 = Pawn.new(icon: "white pawn")
    @white_pawn_2 = Pawn.new(icon: "white pawn")
    @white_pawn_3 = Pawn.new(icon: "white pawn")
    @white_pawn_4 = Pawn.new(icon: "white pawn")
    @white_pawn_5 = Pawn.new(icon: "white pawn")
    @white_pawn_6 = Pawn.new(icon: "white pawn")
    @white_pawn_7 = Pawn.new(icon: "white pawn")
    @white_pawn_8 = Pawn.new(icon: "white pawn")
  end
  
  def populate_board
    self.update_attributes(locations: [[@black_rook_1, @black_knight_1, @black_bishop_1, @black_queen, @black_king, @black_bishop_2, @black_knight_2, @black_rook_2], 
    [@black_pawn_1, @black_pawn_2, @black_pawn_3, @black_pawn_4, @black_pawn_5, @black_pawn_6, @black_pawn_7, @black_pawn_8],
    [nil, nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil, nil],
    [@white_pawn_1, @white_pawn_2, @white_pawn_3, @white_pawn_4, @white_pawn_5, @white_pawn_6, @white_pawn_7, @white_pawn_8],
    [@white_rook_1, @white_knight_1, @white_bishop_1, @white_queen, @white_king, @white_bishop_2, @white_knight_2, @white_rook_2]])
  end
    
end
