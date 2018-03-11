class ChessPiece < ApplicationRecord

  # Obstructed means that another piece is in the spot the piece is trying to move to

  def is_obstructed?(x, y)

    board = @board
    target_value = board[x][y]

    # target => where the piece is trying to move
    if target_value > nil # target is populated with a piece
      true
    else
      false
    end
  end

end
