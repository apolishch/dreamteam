require 'rails_helper'

RSpec.describe King, type: :model do
    
    describe '#opponent_pieces' do
        let(:game) {FactoryBot.create(:game)}
        let(:queen_b) {FactoryBot.create(:queen, game_id: game.id, x_position: 3, y_position: 4, color: false)}
        let(:queen_w) {FactoryBot.create(:queen, game_id: game.id, x_position: 4, y_position: 4, color: true)}
        let(:king_b) {FactoryBot.create(:king, game_id: game.id, x_position: 3, y_position: 2, color: false)}
        let(:king_w) {FactoryBot.create(:king, game_id: game.id, x_position: 1, y_position: 2, color: true)}
        let(:rook_b) {FactoryBot.create(:rook, game_id: game.id, x_position: 4, y_position: 2, color: false)}
        let(:rook_w) {FactoryBot.create(:rook, game_id: game.id, x_position: 2, y_position: 2, color: true)}
        
        it 'only returns white pieces when the user\'s pieces are black' do
            opponent_pieces = king_b.opponent_pieces
            opponent_pieces.each do |opponent_piece|
                expect(opponent_piece.color).to eq(true)
            end
            expect(king_b.color).to eq(false)
        end
        
        it 'only returns black pieces when the user\'s pieces are white' do
            opponent_pieces = king_w.opponent_pieces
            opponent_pieces.each do |opponent_piece|
                expect(opponent_piece.color).to eq(false)
            end
            expect(king_w.color).to eq(true)
        end
        
        it 'only returns the number of pieces the opponent has' do
            expect(king_b.opponent_pieces.count).to eq(16)
        end
    end
    
    describe 'pieces causing '
    
    # describe '#in_check?' do
    #     let(:game) {FactoryBot.create(:game)}
    #     let(:queen_b) {FactoryBot.create(:queen, game_id: game.id, x_position: 3, y_position: 4, color: false)}
    #     let(:queen_w) {FactoryBot.create(:queen, game_id: game.id, x_position: 4, y_position: 4, color: true)}
    #     let(:king_b) {FactoryBot.create(:king, game_id: game.id, x_position: 3, y_position: 2, color: false)}
    #     let(:king_w) {FactoryBot.create(:king, game_id: game.id, x_position: 1, y_position: 2, color: true)}
    #     let(:rook_b) {FactoryBot.create(:rook, game_id: game.id, x_position: 4, y_position: 2, color: false)}
    #     let(:rook_w) {FactoryBot.create(:rook, game_id: game.id, x_position: 2, y_position: 2, color: true)}
        
    #     it ''
    # end
    
end