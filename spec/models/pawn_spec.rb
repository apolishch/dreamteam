require 'rails_helper'

RSpec.describe Pawn, type: :model do

  context 'non valid moves' do
    let(:game) {FactoryBot.create(:game)}
    let(:black_pawn) {FactoryBot.create(:pawn, color: false, game_id: game.id, x_position: 1, y_position: 1)}
    let(:white_pawn) {FactoryBot.create(:pawn, color: true, game_id: game.id, x_position: 1, y_position: 6)}

    it "should not allow pawn to move to it's current position" do
      expect(black_pawn.valid_move?(1, 1)).to eq false
      expect(white_pawn.valid_move?(1, 6)).to eq false
    end

    it "should not be valid if piece is obstructed" do
      FactoryBot.create(:pawn, color: true, game_id: game.id, x_position: 1, y_position: 2)

      expect(black_pawn.valid_move?(1, 1)).to eq false
      expect(black_pawn.valid_move?(1, 3)).to eq false
    end

    it "can't move backwards" do
      white_pawn2 = FactoryBot.create(:pawn, color: true, game_id: game.id, x_position: 1, y_position: 3)
      black_pawn2 = FactoryBot.create(:pawn, color: false, game_id: game.id, x_position: 2, y_position: 4)

      expect(white_pawn2.valid_move?(1, 4)).to eq false
      expect(black_pawn2.valid_move?(2, 3)).to eq false
    end
  end

  context 'valid moves' do
    let(:game) {FactoryBot.create(:game)}
    let(:black_pawn1) {FactoryBot.create(:pawn, color: false, game_id: game.id, x_position: 2, y_position: 2)}
    let(:white_pawn1) {FactoryBot.create(:pawn, color: true, game_id: game.id, x_position: 2, y_position: 5)}

    it "should be able to move 1 tile vertically"  do
      # expect(black_pawn1.valid_move?(2, 3)).to eq true
      expect(white_pawn1.valid_move?(2, 4)).to eq true
    end

    it "should be able to move diagonally if capturing" do
      expect(black_pawn1.valid_move?(3, 3)).to eq true
      expect(white_pawn1.valid_move?(3, 4)).to eq true
    end

    it "can move 2 down if the piece color is black and piece is in starting position" do
      black_pawn2 = FactoryBot.create(:pawn, color: false, game_id: game.id, x_position: 0, y_position: 1, promotable: false)

      expect(black_pawn2.valid_move?(0, 3)).to eq true
    end

    it "can move 2 up if the color is white and piece is in starting position" do
      white_pawn2 = FactoryBot.create(:pawn, color: true, game_id: game.id, x_position: 0, y_position: 6, promotable: false)

      expect(white_pawn2.valid_move?(0, 4)).to eq true
    end
  end
end
