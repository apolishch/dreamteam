require 'rails_helper'

RSpec.describe Knight, type: :model do

  describe '#valid_move?' do
    let(:game) {FactoryBot.create(:game)}
    let(:knight) {FactoryBot.create(:knight, game_id: game.id, x_position: 4, y_position: 4)}
    
    it 'L moves are valid' do
      expect(knight.valid_move?(3, 6)).to eq true
    end

    it '¬ moves are valid' do
      expect(knight.valid_move?(5, 2)).to eq true
    end

    it 'non L moves are invalid' do
      expect(knight.valid_move?(2, 2)).to eq false
    end
  end

end