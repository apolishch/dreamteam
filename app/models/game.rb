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
 
  def both_players?
    user_id.present? && opponent_id.present?
  end
 
  def in_game?(user)
    user.id == user_id || user.id == opponent_id
  end

  def populate_board
    populate_boundary_pieces(0, false)
    populate_interior_pieces(1, false)
    populate_interior_pieces(6, true)
    populate_boundary_pieces(7, true)
  end

  def pieces_remaining(color)
    pieces.includes(:game).where(
      "color = ? and state != 'off-board'",
      color).to_a
  end

  def change_turn
    if turn == user_id
      update_attributes(turn: opponent_id)
    else 
      update_attributes(turn: user_id)
    end
  end
    
  private

  def populate_boundary_pieces(row, color)
    svgblack = ["br.svg", "bn.svg", "bb.svg", "bq.svg", "bk.svg", "bb.svg", "bn.svg", "br.svg"]
    svgwhite = ["wr.svg", "wn.svg", "wb.svg", "wq.svg", "wk.svg", "wb.svg", "wn.svg", "wr.svg"]
    svg = color ? svgwhite : svgblack

    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
      .each_with_index do |klass, index|
        piece = klass.create(game_id: id,
                             color: color,
                             x_position: index,
                             y_position: row,
                             icon: svg[index])
      end
  end

  def populate_interior_pieces(row, color)
    svg = ["wp.svg", "bp.svg"]
    icon = color ? svg[0] : svg[1]

    8.times do |index|
      piece = Pawn.create(game_id: id,
                          color: color,
                          x_position: index,
                          y_position: row,
                          icon: icon)
    end
  end

end
