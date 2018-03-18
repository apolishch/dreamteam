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
    let(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, color: false, x_position: 2, y_position: 2)}
    let(:capture_x) { 3 }
    let(:capture_y) { 3 }
    let(:capture_piece) {FactoryBot.create(:chess_piece, game_id: game.id, color: true, x_position: capture_x, y_position: capture_y)}

    it 'does nothing if there is not a piece here' do
      piece.capture(-100, -100)
      expect(capture_piece).not_to be_deleted?
    end

  end


end
