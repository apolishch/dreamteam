require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

  describe "pieces#update" do

    context "When piece's location is updated" do
      before :each do
        game = FactoryBot.create(:game)
        piece = FactoryBot.create(:chess_piece, x_position: 2, y_position: 1)
        # patch :update, id: @piece.id, piece: { x_position: 2, y_position: 2 }
        # patch :update, game: { id: game.id }, piece: { id: piece.id, x_position: 2, y_position: 2 }
        put :update, game: { id: game.id }, piece: { id: piece.id, new_x_position: 2, new_y_position: 2 }
      end

      it "Should create a new move in the moves table" do
        expect (piece.moves.new_y_position).to eq(2)
        expect (Move.new(game_id: game.id, chess_piece_id: piece.id, x_position: 2, y_position: 1, new_x_position: 2, new_y_position: 2)).to eq(true)
      end

    end
  end

end
