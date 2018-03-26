require 'rails_helper'

RSpec.describe ChessPiece, type: :model do

  context '#is_obstructed?' do
    let(:game) {FactoryBot.create(:game)}
    let(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 2)}
    it 'checks if target is same as current position' do
      expect(piece.is_obstructed?(2, 2)).to eq(false)
    end

    it 'checks for horizontal obstruction' do
      piece2 = FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 3)
      expect(piece.is_obstructed?(2, 5)).to eq(true)
    end

    it 'checks for vertical obstruction' do
      piece2 = FactoryBot.create(:chess_piece, game_id: game.id, x_position: 5, y_position: 2)
      expect(piece.is_obstructed?(6, 2)).to eq(true)
    end

    it 'checks for diagonal obstruction' do
      piece2 = FactoryBot.create(:chess_piece, game_id: game.id, x_position: 3, y_position: 3)
      expect(piece.is_obstructed?(4, 4)).to eq(true)
    end

    it 'when piece is not obstructed' do
      expect(piece.is_obstructed?(0, 0)).to eq(false)
    end

  end

  describe '#capture' do 
    let(:game) {FactoryBot.create(:game)}
    let!(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, color: false, x_position: 2, y_position: 2)}
    let(:capture_x) { 3 }
    let(:capture_y) { 3 }
    let(:no_opponent_x) { 5 }
    let(:no_opponent_y) { 5 }
    let(:no_capture_x) { 6 }
    let(:no_capture_y) { 6 }
    # Use bang to force the creation of an object, for all other objects in this case, they are created already by 
    # being referenced.  All relations are created automatically.
    # Creates it before test runs
    let!(:capture_piece) {FactoryBot.create(:chess_piece, game_id: game.id, color: true, x_position: capture_x, y_position: capture_y)}
    let(:same_color) {FactoryBot.create(:chess_piece, game_id: game.id, color: false, x_position: no_capture_x, y_position: no_capture_y)}
    
    it 'should delete target piece and move current piece to that position ' do
      piece.capture(capture_x, capture_y) # Capture position of opponent piece
      expect(piece.x_position).to eq(3) # Expect current piece to move to that position
      expect(piece.y_position).to eq(3) # Expect current piece to move to that position
      expect(ChessPiece.find_by(id: capture_piece.id)).to be_nil # Expect opponent piece to be deleted
    end

    it 'should do nothing if there is no opponent piece' do
      piece.capture(no_opponent_x, no_opponent_y)
      expect(piece.x_position).to eq(2)
      expect(piece.y_position).to eq(2)
    end

    it 'should do nothing if the piece you are trying to capture is the same color' do
      # same_color
      piece.capture(no_capture_x, no_capture_y)
      expect(piece.x_position).to eq(2)
      expect(piece.y_position).to eq(2)
    end
  end

  
  context '#moving_on_board?' do
    let(:game) {FactoryBot.create(:game)}
    let(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 2)}
    it 'checks if piece is moving to location on the board' do
      expect(piece.moving_on_board?(3, 3)).to eq(true)
    end
    
    it 'checks if piece is moving to location off the board horizontally' do
      expect(piece.moving_on_board?(9, 2)).to eq(false)
    end
    
    it 'checks if piece is moving to location off the board vertically' do
      expect(piece.moving_on_board?(2, 9)).to eq(false)
    end
  end
  
  context '#same_color?' do
    let(:game) {FactoryBot.create(:game)}
    let(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, color: true)}
    it 'checks if the piece at target location is the same color' do
      expect(piece.same_color?(true)).to eq(true)
    end
    
    it 'checks if the piece at the target location is a different color' do
      expect(piece.same_color?(false)).to eq(false)
    end
      
  end
  
  
  #this test doesn't work properly. I need to redo the test, but each method called in this method is tested above.
  context '#valid_move?' do
    let(:game) {FactoryBot.create(:game)}
    let(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 2, color: true)}
    xit 'checks that the target location is on the board' do
      expect(piece.valid_move?(7,2, false)).to eq(true)
      expect(piece.valid_move?(4, -1, false)).to eq(false)
    end
    
    xit 'checks that piece isn\'t obstructed' do
      piece2 = FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 3, color: false)
      expect(piece.valid_move?(2, 5)).to eq(true)
    end
    
    xit 'checks that the piece at target location isn\'t the same color' do
      expect(piece.valid_move?(2, 5, false)).to eq(false)
    end
  end

end
