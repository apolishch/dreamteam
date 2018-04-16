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
  # after_save :populate_board, on: :create
  
  
  def forfeit(forfeitter)
    self.set_winner(forfeitter)
    self.update_game_status("complete")
  end
  
  def find_winner_id(loser)
    players_ids = [self.user_id, self.opponent_id]
    winner_id = players_ids.find { |player_id| player_id != loser.id }
    
    winner_id
  end
    
  def set_winner(loser)
    winner_id = self.find_winner_id(loser)
    
    self.update_attributes(winner_id: winner_id)
  end
    
  def update_game_status(desired_status)
    self.update_attributes(status: desired_status)
  end
    
    
  
  def populate_board
    Rook.create(game_id: id, x_position: 0, y_position: 0, color: false, icon: "black rook")
    Rook.create(game_id: id, x_position: 7, y_position: 0, color: false, icon: "black rook")
    Knight.create(game_id: id, x_position: 1, y_position: 0, color: false, icon: "black knight")
    Knight.create(game_id: id, x_position: 6, y_position: 0, color: false, icon: "black knight")
    Bishop.create(game_id: id, x_position: 2, y_position: 0, color: false, icon: "black bishop")
    Bishop.create(game_id: id, x_position: 5, y_position: 0, color: false, icon: "black bishop")
    Queen.create(game_id: id, x_position: 3, y_position: 0, color: false, icon: "black queen")
    King.create(game_id: id, x_position: 4, y_position: 0, color: false, icon: "black king")
    Pawn.create(game_id: id, x_position: 0, y_position: 1, color: false, icon: "black pawn")
    Pawn.create(game_id: id, x_position: 1, y_position: 1, color: false, icon: "black pawn")
    Pawn.create(game_id: id, x_position: 2, y_position: 1, color: false, icon: "black pawn")
    Pawn.create(game_id: id, x_position: 3, y_position: 1, color: false, icon: "black pawn")
    Pawn.create(game_id: id, x_position: 4, y_position: 1, color: false, icon: "black pawn")
    Pawn.create(game_id: id, x_position: 5, y_position: 1, color: false, icon: "black pawn")
    Pawn.create(game_id: id, x_position: 6, y_position: 1, color: false, icon: "black pawn")
    Pawn.create(game_id: id, x_position: 7, y_position: 1, color: false, icon: "black pawn")
    Rook.create(game_id: id, x_position: 0, y_position: 7, color: true, icon: "white rook")
    Rook.create(game_id: id, x_position: 7, y_position: 7, color: true, icon: "white rook")
    Knight.create(game_id: id, x_position: 1, y_position: 7, color: true, icon: "white knight")
    Knight.create(game_id: id, x_position: 6, y_position: 7, color: true, icon: "white knight")
    Bishop.create(game_id: id, x_position: 2, y_position: 7, color: true, icon: "white bishop")
    Bishop.create(game_id: id, x_position: 5, y_position: 7, color: true, icon: "white bishop")
    Queen.create(game_id: id, x_position: 3, y_position: 7, color: true, icon: "white queen")
    King.create(game_id: id, x_position: 4, y_position: 7, color: true, icon: "white king")
    Pawn.create(game_id: id, x_position: 0, y_position: 6, color: true, icon: "white pawn")
    Pawn.create(game_id: id, x_position: 1, y_position: 6, color: true, icon: "white pawn")
    Pawn.create(game_id: id, x_position: 2, y_position: 6, color: true, icon: "white pawn")
    Pawn.create(game_id: id, x_position: 3, y_position: 6, color: true, icon: "white pawn")
    Pawn.create(game_id: id, x_position: 4, y_position: 6, color: true, icon: "white pawn")
    Pawn.create(game_id: id, x_position: 5, y_position: 6, color: true, icon: "white pawn")
    Pawn.create(game_id: id, x_position: 6, y_position: 6, color: true, icon: "white pawn")
    Pawn.create(game_id: id, x_position: 7, y_position: 6, color: true, icon: "white pawn")
    
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
