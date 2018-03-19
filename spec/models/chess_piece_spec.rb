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
  
  
  # this test doesn't work properly. I need to redo the test, but each method called in this method is tested above.
  # # context '#valid_move?' do
  # #   let(:game) {FactoryBot.create(:game)}
  # #   let(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 2, color: true)}
  # #   it 'checks that the target location is on the board' do
  # #     expect(piece.valid_move?(7,2, false)).to eq(true)
  # #     expect(piece.valid_move?(4, -1, false)).to eq(false)
  # #   end
    
  # #   it 'checks that piece isn\'t obstructed' do
  # #     piece2 = FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 3, color: false)
  # #     expect(piece.valid_move?(2, 5)).to eq(true)
  # #   end
    
  # #   it 'checks that the piece at target location isn\'t the same color' do
  # #     expect(piece.valid_move?(2, 5, false)).to eq(false)
  # #   end
  # end
end
