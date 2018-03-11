class Game < ApplicationRecord
  belongs_to :user
  has_many :chess_pieces
  has_many :rooks
  has_many :knights
  has_many :bishops
  has_many :queens
  has_many :kings
  has_many :pawns
  validates :game_name, presence: true
  
  def populate_board
    # builds each piece
    @black_rook_1 = Rook.new(game_id: id, x_position: 0, y_position: 0, color: false, icon: "black rook")
    @black_rook_2 = Rook.new(game_id: id, x_position: 7, y_position: 0, color: false, icon: "black rook")
    @black_knight_1 = Knight.new(game_id: id, x_position: 1, y_position: 0, color: false, icon: "black knight")
    @black_knight_2 = Knight.new(game_id: id, x_position: 6, y_position: 0, color: false, icon: "black knight")
    @black_bishop_1 = Bishop.new(game_id: id, x_position: 2, y_position: 0, color: false, icon: "black bishop")
    @black_bishop_2 = Bishop.new(game_id: id, x_position: 5, y_position: 0, color: false, icon: "black bishop")
    @black_queen = Queen.new(game_id: id, x_position: 3, y_position: 0, color: false, icon: "black queen")
    @black_king = King.new(game_id: id, x_position: 4, y_position: 0, color: false, icon: "black king")
    @black_pawn_1 = Pawn.new(game_id: id, x_position: 0, y_position: 1, color: false, icon: "black pawn")
    @black_pawn_2 = Pawn.new(game_id: id, x_position: 1, y_position: 1, color: false, icon: "black pawn")
    @black_pawn_3 = Pawn.new(game_id: id, x_position: 2, y_position: 1, color: false, icon: "black pawn")
    @black_pawn_4 = Pawn.new(game_id: id, x_position: 3, y_position: 1, color: false, icon: "black pawn")
    @black_pawn_5 = Pawn.new(game_id: id, x_position: 4, y_position: 1, color: false, icon: "black pawn")
    @black_pawn_6 = Pawn.new(game_id: id, x_position: 5, y_position: 1, color: false, icon: "black pawn")
    @black_pawn_7 = Pawn.new(game_id: id, x_position: 6, y_position: 1, color: false, icon: "black pawn")
    @black_pawn_8 = Pawn.new(game_id: id, x_position: 7, y_position: 1, color: false, icon: "black pawn")
    @white_rook_1 = Rook.new(game_id: id, x_position: 0, y_position: 7, color: true, icon: "white rook")
    @white_rook_2 = Rook.new(game_id: id, x_position: 7, y_position: 7, color: true, icon: "white rook")
    @white_knight_1 = Knight.new(game_id: id, x_position: 1, y_position: 7, color: true, icon: "white knight")
    @white_knight_2 = Knight.new(game_id: id, x_position: 6, y_position: 7, color: true, icon: "white knight")
    @white_bishop_1 = Bishop.new(game_id: id, x_position: 2, y_position: 7, color: true, icon: "white bishop")
    @white_bishop_2 = Bishop.new(game_id: id, x_position: 5, y_position: 7, color: true, icon: "white bishop")
    @white_queen = Queen.new(game_id: id, x_position: 3, y_position: 7, color: true, icon: "white queen")
    @white_king = King.new(game_id: id, x_position: 4, y_position: 7, color: true, icon: "white king")
    @white_pawn_1 = Pawn.new(game_id: id, x_position: 0, y_position: 6, color: true, icon: "white pawn")
    @white_pawn_2 = Pawn.new(game_id: id, x_position: 1, y_position: 6, color: true, icon: "white pawn")
    @white_pawn_3 = Pawn.new(game_id: id, x_position: 2, y_position: 6, color: true, icon: "white pawn")
    @white_pawn_4 = Pawn.new(game_id: id, x_position: 3, y_position: 6, color: true, icon: "white pawn")
    @white_pawn_5 = Pawn.new(game_id: id, x_position: 4, y_position: 6, color: true, icon: "white pawn")
    @white_pawn_6 = Pawn.new(game_id: id, x_position: 5, y_position: 6, color: true, icon: "white pawn")
    @white_pawn_7 = Pawn.new(game_id: id, x_position: 6, y_position: 6, color: true, icon: "white pawn")
    @white_pawn_8 = Pawn.new(game_id: id, x_position: 7, y_position: 6, color: true, icon: "white pawn")
    
    # sets default state for board
    # self.update_attributes(locations: [[@black_rook_1, @black_knight_1, @black_bishop_1, @black_queen, @black_king, @black_bishop_2, @black_knight_2, @black_rook_2], 
    # [@black_pawn_1, @black_pawn_2, @black_pawn_3, @black_pawn_4, @black_pawn_5, @black_pawn_6, @black_pawn_7, @black_pawn_8],
    # [nil, nil, nil, nil, nil, nil, nil, nil],
    # [nil, nil, nil, nil, nil, nil, nil, nil],
    # [nil, nil, nil, nil, nil, nil, nil, nil],
    # [nil, nil, nil, nil, nil, nil, nil, nil],
    # [@white_pawn_1, @white_pawn_2, @white_pawn_3, @white_pawn_4, @white_pawn_5, @white_pawn_6, @white_pawn_7, @white_pawn_8],
    # [@white_rook_1, @white_knight_1, @white_bishop_1, @white_queen, @white_king, @white_bishop_2, @white_knight_2, @white_rook_2]])
  end
    
end
