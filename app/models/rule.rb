class Board < ApplicationRecord
  attr_accessor :board
  # serialize :board_game, Array

  def initialize(board)
    @board = board
  end

  def set_board
    self.board_game =
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
    if board_game[row][col]
      type, color = board_game[row][col].split('|')
    else
      nil
    end
  end

end

puts Board.set_board
