require 'rails_helper'

RSpec.describe King, type: :model do
    
    describe '#opponent_pieces' do
        let(:game) {FactoryBot.create(:game)}
        let(:queen_b) {FactoryBot.create(:queen, game_id: game.id, x_position: 3, y_position: 4, color: false)}
        let(:queen_w) {FactoryBot.create(:queen, game_id: game.id, x_position: 4, y_position: 4, color: true)}
        let(:king_b) {FactoryBot.create(:king, game_id: game.id, x_position: 3, y_position: 2, color: false)}
        let(:king_w) {FactoryBot.create(:king, game_id: game.id, x_position: 1, y_position: 2, color: false)}
        let(:rook_b) {FactoryBot.create(:rook, game_id: game.id, x_position: 4, y_position: 2, color: false)}
        let(:rook_w) {FactoryBot.create(:rook, game_id: game.id, x_position: 2, y_position: 2, color: false)}
        
        it 'returns the opponent\'s pieces' do
            expect(king_b.opponent_pieces.take.color).to eq(true)
            expect(king_b.opponent_pieces.count).to eq(3)
        end
    end
    
end