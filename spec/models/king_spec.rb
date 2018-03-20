require 'rails_helper'

RSpec.describe King, type: :model do
  
  describe '#is_move_allowed?' do
    let(:king) { FactoryBot.create(:king) }

    it 'should test if horizontal moves are valid' do
      expect(king.is_move_allowed?(5, 4)).to eq true
    end

    it 'should test if vertical moves are valid' do 
      expect(king.is_move_allowed?(4, 5)).to eq true
    end

    it 'should test if diagonal moves are valid' do
      expect(king.is_move_allowed?(5, 5)).to eq true
    end

    it 'should not allow movements greater than 1 in all directions' do
      expect(king.is_move_allowed?(1, 1)).to eq false
    end
  end
  
end