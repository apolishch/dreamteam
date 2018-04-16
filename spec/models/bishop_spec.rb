require 'rails_helper'

RSpec.describe Bishop, type: :model do

  describe '#valid_move?' do
    let(:game) {FactoryBot.create(:game)}
    let(:bishop) {FactoryBot.create(:bishop, game_id: game.id, x_position: 4, y_position: 4, color: true)}
    
    it 'shows diagonal moves are valid' do
      expect(bishop.valid_move?(5, 5)).to eq true
    end

    it 'shows non diagonal moves are invalid' do
      expect(bishop.valid_move?(4, 6)).to eq false
    end
  end

end