require 'rails_helper'

RSpec.describe Queen, type: :model do

  describe '#valid_move?' do
    let(:game) {FactoryBot.create(:game)}
    let(:queen) {FactoryBot.create(:queen, game_id: game.id, x_position: 4, y_position: 4)}
    
    it 'diagonal moves are valid' do
      expect(queen.valid_move?(5, 5)).to eq true
    end
    
    it 'horizontal moves are valid' do
      expect(queen.valid_move?(7, 4)).to eq true
    end

    it 'vertical moves are valid' do
      expect(queen.valid_move?(4, 6)).to eq true
    end

    it 'non diagonal, vertical or horizontal moves are invalid' do
      expect(queen.valid_move?(3, 2)).to eq false
    end
  end

end