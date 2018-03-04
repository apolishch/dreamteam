class Board < ApplicationRecord
  serialize :game_board, Array

  def set_board
    self.game_board =
    [
      [ 'rook|white', 'knight|white', 'bishop|white', 'queen|white', 'king|white', 'bishop|white', 'knight|white', 'rook|white' ],
      [ 'pawn|white', 'pawn|white',   'pawn|white',   'pawn|white',  'pawn|white', 'pawn|white',   'pawn|white',   'pawn|white' ],
      [  nil,          nil,            nil,            nil,           nil,          nil,            nil,            nil         ],
      [  nil,          nil,            nil,            nil,           nil,          nil,            nil,            nil         ],
      [  nil,          nil,            nil,            nil,           nil,          nil,            nil,            nil         ],
      [  nil,          nil,            nil,            nil,           nil,          nil,            nil,            nil         ],
      [ 'pawn|black', 'pawn|black',   'pawn|black',   'pawn|black',  'pawn|black', 'pawn|black',   'pawn|black',   'pawn|black' ],
      [ 'rook|black', 'knight|black', 'bishop|black', 'queen|black', 'king|black', 'bishop|black', 'knigh|blackt', 'rook|black' ]
    ]
    save!
  end

  def at(row, col)
    if game_board[row][col]
      type, color = game_board[row][col].split('|')
    else
      nil
    end
  end

end