require 'rails_helper'

RSpec.describe Rook, type: :model do

  describe '#valid_move?' do
    let(:game) {FactoryBot.create(:game)}
    let(:rook) {FactoryBot.create(:rook, game_id: game.id, x_position: 4, y_position: 4)}
    
    it 'horizontal moves are valid' do
      expect(rook.valid_move?(7, 4)).to eq true
    end

    it 'vertical moves are valid' do
      expect(rook.valid_move?(4, 6)).to eq true
    end

    it 'non horizontal, non vertical moves are invalid' do
      expect(rook.valid_move?(6, 6)).to eq false
    end
  end

end