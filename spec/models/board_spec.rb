require 'rails_helper'

RSpec.describe Board, type: :model do
  describe '#set_board' do 
    it 'should initialize board with correct pieces' do
      board = Board.new

      board.set_board

      expect(board.game_board).to eq([
        [ 'rook|white', 'knight|white', 'bishop|white', 'queen|white', 'king|white', 'bishop|white', 'knight|white', 'rook|white' ],
        [ 'pawn|white', 'pawn|white',   'pawn|white',   'pawn|white',  'pawn|white', 'pawn|white',   'pawn|white',   'pawn|white' ],
        [  nil,          nil,            nil,            nil,           nil,          nil,            nil,            nil         ],
        [  nil,          nil,            nil,            nil,           nil,          nil,            nil,            nil         ],
        [  nil,          nil,            nil,            nil,           nil,          nil,            nil,            nil         ],
        [  nil,          nil,            nil,            nil,           nil,          nil,            nil,            nil         ],
        [ 'pawn|black', 'pawn|black',   'pawn|black',   'pawn|black',  'pawn|black', 'pawn|black',   'pawn|black',   'pawn|black' ],
        [ 'rook|black', 'knight|black', 'bishop|black', 'queen|black', 'king|black', 'bishop|black', 'knigh|blackt', 'rook|black' ]
      ])
    end
  end
  describe '#at' do 
    it 'should return correct type of piece' do
      board = Board.new
      board.set_board

      type, color = board.at(0,0)  
    
      expect(type).to eq("rook")
    end

    it 'should return correct color of piece' do
      board = Board.new
      board.set_board

      type, color = board.at(0,0)  
    
      expect(color).to eq("white")
    end
  end
end
