require 'rails_helper'

RSpec.describe King, type: :model do

    describe '#opponent_pieces' do
        let(:game) {FactoryBot.create(:game)}
        let!(:queen_b) {FactoryBot.create(:queen, game_id: game.id, x_position: 1, y_position: 5, color: false)}
        let!(:queen_w) {FactoryBot.create(:queen, game_id: game.id, x_position: 3, y_position: 4, color: true)}
        let!(:king_b) {FactoryBot.create(:king, game_id: game.id, x_position: 3, y_position: 2, color: false)}
        let!(:king_w) {FactoryBot.create(:king, game_id: game.id, x_position: 1, y_position: 4, color: true)}
        let!(:rook_b) {FactoryBot.create(:rook, game_id: game.id, x_position: 1, y_position: 2, color: false)}
        let!(:rook_w) {FactoryBot.create(:rook, game_id: game.id, x_position: 5, y_position: 3, color: true)}


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
            expect(king_b.opponent_pieces.count).to eq(3)
        end
    end

    describe '#pieces_causing_check' do
        let(:game) {FactoryBot.create(:game)}
        let!(:queen_b) {FactoryBot.create(:queen, game_id: game.id, x_position: 1, y_position: 5, color: false)}
        let!(:queen_w) {FactoryBot.create(:queen, game_id: game.id, x_position: 3, y_position: 4, color: true)}
        let!(:king_b) {FactoryBot.create(:king, game_id: game.id, x_position: 3, y_position: 2, color: false)}
        let!(:king_w) {FactoryBot.create(:king, game_id: game.id, x_position: 1, y_position: 4, color: true)}
        let!(:rook_b) {FactoryBot.create(:rook, game_id: game.id, x_position: 1, y_position: 2, color: false)}
        let!(:rook_w) {FactoryBot.create(:rook, game_id: game.id, x_position: 5, y_position: 3, color: true)}

        it 'builds an array with only the pieces that cause a king to be in check' do
            expect(king_b.pieces_causing_check.count).to eq(1)
            expect(king_w.pieces_causing_check.count).to eq(2)

        end
    end

     describe '#in_check?' do
        let(:game) {FactoryBot.create(:game)}
        let!(:queen_b) {FactoryBot.create(:queen, game_id: game.id, x_position: 1, y_position: 5, color: false)}
        let!(:queen_w) {FactoryBot.create(:queen, game_id: game.id, x_position: 3, y_position: 4, color: true)}
        let!(:king_b) {FactoryBot.create(:king, game_id: game.id, x_position: 3, y_position: 2, color: false)}
        let!(:king_w) {FactoryBot.create(:king, game_id: game.id, x_position: 5, y_position: 4, color: true)}
        let!(:rook_b) {FactoryBot.create(:rook, game_id: game.id, x_position: 1, y_position: 2, color: false)}
        let!(:rook_w) {FactoryBot.create(:rook, game_id: game.id, x_position: 5, y_position: 3, color: true)}

        it 'returns true if the user\'s king is in check' do
            expect(king_b.in_check?).to eq(true)
        end

        it 'returns false if a user\'s king is not in check' do
            expect(king_w.in_check?).to eq(false)
        end
    end


  describe '#valid_move?' do
    let(:game) {FactoryBot.create(:game)}
    let!(:king) {FactoryBot.create(:king, game_id: game.id, x_position: 4, y_position: 4)}

    it 'should test if horizontal moves are valid' do
      expect(king.valid_move?(5, 4)).to eq true
    end

    it 'should test if vertical moves are valid' do
      expect(king.valid_move?(4, 5)).to eq true
    end

    it 'should test if diagonal moves are valid' do
      expect(king.valid_move?(5, 5)).to eq true
    end

    it 'should not allow horizontal movements greater than 1' do
      expect(king.valid_move?(6, 4)).to eq false
    end

    it 'should not allow vertical movements greater than 1' do
      expect(king.valid_move?(4, 6)).to eq false
    end

    it 'should not allow vertical movements greater than 1' do
      expect(king.valid_move?(4, 2)).to eq false
    end

    it 'should not allow diagonal movements greater than 1' do
      expect(king.valid_move?(6, 6)).to eq false
    end

    it 'should not allow far away movements' do
      expect(king.valid_move?(7, 3)).to eq false
    end
  end

  describe '#checkmate?' do
    let(:game) {FactoryBot.create(:game)}
    let!(:king) {FactoryBot.create(:king, game_id: game.id, x_position: 0, y_position: 0, color: true)}

    describe 'when not in check' do
      it 'returns false' do
        expect(king.in_check?).to eq(false)
        expect(king.checkmate?).to eq(false)
      end
    end

    describe 'when in check and there is no way for the king to escape' do
      let!(:enemy_rook) { FactoryBot.create(:rook, game_id: game.id, x_position: 0, y_position: 2, color: false) }
      let!(:enemy_rook2) { FactoryBot.create(:rook, game_id: game.id, x_position: 1, y_position: 2, color: false) }

      it 'returns true' do
        # binding.pry
        expect(king.checkmate?).to eq true
      end
    end

    describe 'when in check and there is a way for the king to escape' do
      let!(:enemy_rook) { FactoryBot.create(:rook, game_id: game.id, x_position: 0, y_position: 2, color: false) }

      it 'returns false' do
        expect(king.checkmate?).to eq false
      end
    end

    describe 'when in check '
  end

  describe '#can_escape_from_check?' do
    let(:game) {FactoryBot.create(:game)}
    let!(:king) {FactoryBot.create(:king, game_id: game.id, x_position: 4, y_position: 4, color: true)}
    let!(:king2) {FactoryBot.create(:king, game_id: game.id, x_position: 2, y_position: 6, color: true)}
    let!(:rook) {FactoryBot.create(:rook, game_id: game.id, x_position: 4, y_position: 2, color: false)}
    let!(:rook2) {FactoryBot.create(:rook, game_id: game.id, x_position: 2, y_position: 4, color: false)}
    let!(:rook3) {FactoryBot.create(:rook, game_id: game.id, x_position: 1, y_position: 4, color: false)}
    let!(:rook4) {FactoryBot.create(:rook, game_id: game.id, x_position: 3, y_position: 4, color: false)}


    describe 'when in check see if king can move out of the way and not be in check' do
      it 'returns true' do
        # allow(king).to receive(:in_check?).and_return(true)
        expect(king.in_check?).to eq(true)
        expect(king.can_escape_from_check?).to eq(true)
      end
    end

    describe 'when in check and there is no way for the king to escape' do
      it 'returns false' do
        expect(king2.in_check?).to eq(true)
        expect(king2.can_escape_from_check?).to eq(false)
      end
    end
  end

end
