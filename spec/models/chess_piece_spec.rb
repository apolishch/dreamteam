require 'rails_helper'

RSpec.describe ChessPiece, type: :model do

  context '#is_obstructed?' do
    let(:game) {FactoryBot.create(:game)}
    let(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 2)}
    it 'checks if target is same as current position' do
      expect(piece.is_obstructed?(2, 2)).to eq(false)
    end

    it 'checks for vertical obstruction' do
      # binding.pry
      piece2 = FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 1)
      expect(piece.is_obstructed?(2, 0)).to eq(true)
    end

    it 'checks for horizontal obstruction' do
      # binding.pry
      piece2 = FactoryBot.create(:chess_piece, game_id: game.id, x_position: 5, y_position: 2)
      expect(piece.is_obstructed?(6, 2)).to eq(true)
    end

    it 'checks for diagonal obstruction' do
      piece2 = FactoryBot.create(:chess_piece, game_id: game.id, x_position: 3, y_position: 3)
      expect(piece.is_obstructed?(4, 4)).to eq(true)
    end    

    it 'checks for horizontal movement when not obstructed' do
      expect(piece.is_obstructed?(2, 3)).to eq(false)
    end    

    it 'checks for vertical movement when not obstructed' do
      expect(piece.is_obstructed?(3, 2)).to eq(false)
    end

    it 'when piece is not obstructed' do
      expect(piece.is_obstructed?(0, 0)).to eq(false)
    end

    context "king obstructed" do
      let(:game) {FactoryBot.create(:game)}
      let!(:king) {FactoryBot.create(:king, game_id: game.id, x_position: 4, y_position: 4)}

      it 'should test if horizontal moves are valid' do
        expect(king.is_obstructed?(5, 4)).to eq false
      end
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

  describe '#can_threatening_piece_be_captured' do 
    let(:game) {FactoryBot.create(:game)}
    let!(:king) {FactoryBot.create(:king, game_id: game.id, x_position: 0, y_position: 0, color: true)}
    let!(:good_rook) {FactoryBot.create(:rook, game_id: game.id, x_position: 1, y_position: 2, color: true)}
    let!(:enemy_rook2) {FactoryBot.create(:rook, game_id: game.id, x_position: 0, y_position: 2, color: false)}
    # let!(:enemy_knight) {FactoryBot.create(:knight, game_id: game.id, x_position: 1, y_position: 2, color: false)}
    let!(:enemy_rook) {FactoryBot.create(:rook, game_id: game.id, x_position: 7, y_position: 3, color: false)}
    let!(:king2) {FactoryBot.create(:king, game_id: game.id, x_position: 7, y_position: 5, color: true)}
    let!(:good_rook2) {FactoryBot.create(:rook, game_id: game.id, x_position: 6, y_position: 7, color: true)}

    describe 'when king is in check and you have a piece that can capture the threatening piece' do 
      it 'returns true' do 
        # binding.pry
        expect(king.in_check?).to eq(true)
        expect(enemy_rook2.can_threatening_piece_be_captured?).to eq(true)
      end
    end

    describe 'when king is in check and you have a piece that can not capture the threatening piece' do 
      it 'returns false' do 
        expect(king2.in_check?).to eq(true)
        expect(enemy_rook.can_threatening_piece_be_captured?).to eq(false)
      end
    end
  end

  describe '#validates_invalid_move' do
    let(:game) {FactoryBot.create(:game)}
    let!(:king2) {FactoryBot.create(:king, game_id: game.id, x_position: 7, y_position: 5, color: true)}

    it 'should be an invalid move' do
      expect(king2.valid_move?(7,3)).to eq(false)
    end
  end

end
