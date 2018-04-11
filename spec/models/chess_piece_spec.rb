require 'rails_helper'

RSpec.describe ChessPiece, type: :model do
  context '#is_obstructed?' do
    let(:game) {FactoryBot.create(:game)}
    let(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 2)}
    it 'checks if target is same as current position' do
      expect(piece.is_obstructed?(2, 2)).to eq(false)
    end

    it 'checks for vertical obstruction' do
      # binding.pry
      piece2 = FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 1)
      expect(piece.is_obstructed?(2, 0)).to eq(true)
    end

    it 'checks for horizontal obstruction' do
      # binding.pry
      piece2 = FactoryBot.create(:chess_piece, game_id: game.id, x_position: 5, y_position: 2)
      expect(piece.is_obstructed?(6, 2)).to eq(true)
    end

    it 'checks for diagonal obstruction' do
      piece2 = FactoryBot.create(:chess_piece, game_id: game.id, x_position: 3, y_position: 3)
      expect(piece.is_obstructed?(4, 4)).to eq(true)
    end

    it 'checks for horizontal movement when not obstructed' do
      expect(piece.is_obstructed?(2, 3)).to eq(false)
    end

    it 'checks for vertical movement when not obstructed' do
      expect(piece.is_obstructed?(3, 2)).to eq(false)
    end

    it 'when piece is not obstructed' do
      expect(piece.is_obstructed?(0, 0)).to eq(false)
    end

    context "king obstructed" do
      let(:game) {FactoryBot.create(:game)}
      let!(:king) {FactoryBot.create(:king, game_id: game.id, x_position: 4, y_position: 4)}

      it 'should test if horizontal moves are valid' do
        expect(king.is_obstructed?(5, 4)).to eq false
      end
    end
  end

  context '#moving_on_board?' do
    let(:game) {FactoryBot.create(:game)}
    let(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 2)}
    it 'checks if piece is moving to location on the board' do
      expect(piece.moving_on_board?(3, 3)).to eq(true)
    end

    it 'checks if piece is moving to location off the board horizontally' do
      expect(piece.moving_on_board?(9, 2)).to eq(false)
    end

    it 'checks if piece is moving to location off the board vertically' do
      expect(piece.moving_on_board?(2, 9)).to eq(false)
    end
  end

  context '#same_color?' do
    let(:game) {FactoryBot.create(:game)}
    let(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, color: true)}
    it 'checks if the piece at target location is the same color' do
      expect(piece.same_color?(true)).to eq(true)
    end

    it 'checks if the piece at the target location is a different color' do
      expect(piece.same_color?(false)).to eq(false)
    end

  end


  #this test doesn't work properly. I need to redo the test, but each method called in this method is tested above.
  context '#valid_move?' do
    let(:game) {FactoryBot.create(:game)}
    let(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 2, color: true)}
    xit 'checks that the target location is on the board' do
      expect(piece.valid_move?(7,2, false)).to eq(true)
      expect(piece.valid_move?(4, -1, false)).to eq(false)
    end

    xit 'checks that piece isn\'t obstructed' do
      piece2 = FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 3, color: false)
      expect(piece.valid_move?(2, 5)).to eq(true)
    end

    xit 'checks that the piece at target location isn\'t the same color' do
      expect(piece.valid_move?(2, 5, false)).to eq(false)
    end
  end

  context '#can_threatening_piece_be_captured?' do
    let(:game) {FactoryBot.create(:game)}
    let!(:king) {FactoryBot.create(:king, game_id: game.id, x_position: 0, y_position: 0, color: true)}
    let!(:good_rook) {FactoryBot.create(:rook, game_id: game.id, x_position: 1, y_position: 2, color: true)}
    let!(:enemy_rook2) {FactoryBot.create(:rook, game_id: game.id, x_position: 0, y_position: 2, color: false)}
    # let!(:enemy_knight) {FactoryBot.create(:knight, game_id: game.id, x_position: 1, y_position: 2, color: false)}
    let!(:enemy_rook) {FactoryBot.create(:rook, game_id: game.id, x_position: 7, y_position: 3, color: false)}
    let!(:king2) {FactoryBot.create(:king, game_id: game.id, x_position: 7, y_position: 5, color: true)}
    let!(:good_rook2) {FactoryBot.create(:rook, game_id: game.id, x_position: 6, y_position: 7, color: true)}

    describe 'when king is in check and you have a piece that can capture the threatening piece' do
      it 'returns true' do
        expect(king.in_check?).to eq(true)
        expect(enemy_rook2.can_threatening_piece_be_captured?).to eq(true)
      end
    end

    describe 'when king is in check and you have a piece that can not capture the threatening piece' do
      it 'returns false' do
        expect(king2.in_check?).to eq(true)
        expect(enemy_rook.can_threatening_piece_be_captured?).to eq(false)
      end
    end
  end

  describe '#validates_invalid_move' do
    let(:game) {FactoryBot.create(:game)}
    let!(:king2) {FactoryBot.create(:king, game_id: game.id, x_position: 7, y_position: 5, color: true)}

    it 'should be an invalid move' do
      expect(king2.valid_move?(7,3)).to eq(false)
    end
  end

  context '#is_diagonal_move?' do
    let(:game) {FactoryBot.create(:game)}
    let!(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 2)}

    it 'should return true if the piece is moving diagonally' do
      expect(piece.is_diagonal_move?(3,3)).to eq(true)
    end

    it 'should return false if the piece is not moving diagonally' do
      expect(piece.is_diagonal_move?(3,2)).to eq(false)
      expect(piece.is_diagonal_move?(2,3)).to eq(false)
    end
  end

  context '#is_horizontal_move?' do
    let(:game) {FactoryBot.create(:game)}
    let!(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 2)}

    it 'should return true if the piece is moving horizontally' do
      expect(piece.is_horizontal_move?(3,2)).to eq(true)
    end

    it 'should return false if the piece is not moving horizontally' do
      expect(piece.is_horizontal_move?(2,3)).to eq(false)
    end
  end

  context '#is_horizontal_move?' do
    let(:game) {FactoryBot.create(:game)}
    let!(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, x_position: 2, y_position: 2)}

    it 'should return true if the piece is moving vertically' do
      expect(piece.is_vertical_move?(2,3)).to eq(true)
    end

    it 'should return false if the piece is not moving vertically' do
      expect(piece.is_vertical_move?(4,3)).to eq(false)
    end
  end

  describe '#can_threat_be_blocked?' do
    let(:game) { FactoryBot.create :game }

    describe 'when the enemy piece can be blocked' do
      let!(:king) { FactoryBot.create :king, game: game, x_position: 0, y_position: 0, color: true }

      describe 'vertical' do
        let(:enemy_rook) { FactoryBot.create :rook, game: game, x_position: 0, y_position: 2, color: false }
        let!(:good_rook) { FactoryBot.create :rook, game: game, x_position: 1, y_position: 1, color: true }

        it 'returns true' do
          expect(enemy_rook.can_threat_be_blocked?).to eq true
        end
      end

      describe 'horizontal' do
        let(:enemy_rook) { FactoryBot.create :rook, game: game, x_position: 2, y_position: 0, color: false }
        let!(:good_rook) { FactoryBot.create :rook, game: game, x_position: 1, y_position: 1, color: true }

        it 'returns true' do
          expect(enemy_rook.can_threat_be_blocked?).to eq true
        end
      end

      describe 'diagonal' do
        let(:enemy_bishop) { FactoryBot.create :bishop, game: game, x_position: 2, y_position: 2, color: false }
        let!(:good_rook) { FactoryBot.create :rook, game: game, x_position: 0, y_position: 1, color: true }

        it 'returns true' do
          expect(enemy_bishop.can_threat_be_blocked?).to eq true
        end
      end
    end

    describe "when the enemy piece can't be blocked" do
      let!(:king) { FactoryBot.create :king, game: game, x_position: 7, y_position: 7, color: true }

      describe 'no heroes' do
        let(:enemy_rook) { FactoryBot.create :rook, game: game, x_position: 7, y_position: 6, color: false }

        it "should return false if king doesn't have heroes" do
          expect(enemy_rook.can_threat_be_blocked?).to eq false
        end
      end

      describe 'vertical' do
        let!(:good_rook) { FactoryBot.create :rook, game: game, x_position: 0, y_position: 7, color: true }
        let!(:enemy_rook) { FactoryBot.create :rook, game: game, x_position: 7, y_position: 5, color: false }

        it 'returns false' do
          expect(enemy_rook.can_threat_be_blocked?).to eq false
        end
      end

      describe 'horizontal' do
        let!(:good_rook) { FactoryBot.create :rook, game: game, x_position: 1, y_position: 1, color: true }
        let!(:enemy_rook) { FactoryBot.create :rook, game: game, x_position: 5, y_position: 7, color: false }

        it 'returns false' do
          expect(enemy_rook.can_threat_be_blocked?).to eq false
        end
      end

      describe 'diagonal' do
        let!(:good_rook) { FactoryBot.create :rook, game: game, x_position: 1, y_position: 1, color: true }
        let!(:enemy_bishop) { FactoryBot.create :bishop, game: game, x_position: 5, y_position: 5, color: false }

        it 'returns false' do
          expect(enemy_bishop.can_threat_be_blocked?).to eq false
        end
      end

      describe 'knight move' do
        let!(:good_rook) { FactoryBot.create :rook, game: game, x_position: 4, y_position: 6, color: true }
        let!(:enemy_knight) { FactoryBot.create :knight, game: game, x_position: 6, y_position: 5, color: false }

        it 'returns false' do
          expect(enemy_knight.can_threat_be_blocked?).to eq false
        end
      end
    end
  end

  describe '#move_to' do 
    let(:user) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:game) { FactoryBot.create :game, turn: user.id, user_id: user.id, opponent_id: user2.id }


    describe 'if desired location coordinates are not occupied' do
      let!(:king) { FactoryBot.create :king, game: game, x_position: 4, y_position: 6, color: true }

      it 'updates the coordinates to the location coordinates' do 
        # binding.pry
        king.move_to(5,6)
        expect(king.x_position).to eq(5)
        expect(king.y_position).to eq(6)
        expect(game.turn).to eq user2.id

        # expect { king.move_to(5,6) }.to change{king.x_position}.to(5)
        # expect { king.y_position }.to eq(6)
      end
    end

    describe 'if desired location coordinates are occupied by a piece of the same color' do 
      let!(:king) { FactoryBot.create :king, game: game, x_position: 4, y_position: 6, color: true }
      let!(:pawn) { FactoryBot.create :pawn, game: game, x_position: 5, y_position: 6, color: true }

      it 'does not update the coordinates of the king' do 
        king.move_to(5,6)
        # binding.pry
        expect(king.x_position).to eq(4)
        expect(king.y_position).to eq(6)
      end
    end

    describe 'if desired location coordinates are occupied by a piece of a different color' do 
      let!(:king) { FactoryBot.create :king, game: game, x_position: 4, y_position: 6, color: true }
      let!(:pawn) { FactoryBot.create :pawn, game: game, x_position: 5, y_position: 6, color: false }

      it 'updates the coordinates of the king and deletes the pawn' do 
        # binding.pry
        king.move_to(5,6)
        expect(king.x_position).to eq(5)
        expect(king.y_position).to eq(6)
        expect(ChessPiece.find_by(id: pawn.id)).to be_nil
      end
    end

  end

  describe '#capture' do 
    # user = FactoryBot.create(:user)
    # user2 = FactoryBot.create(:user)
    # sign_in user 
    # sign_in user2
    # let(:game) { FactoryBot.create(:game, user_id: 1, opponent_id: 2, turn: 1) }
    let(:game) { FactoryBot.create(:game) }
    let!(:king) { FactoryBot.create(:king, game: game, x_position: 4, y_position: 6, color: true) }
    let!(:capture_pawn) {FactoryBot.create(:pawn, game_id: game.id, x_position: 5, y_position: 6, color: false)}
    let!(:good_pawn) {FactoryBot.create(:pawn, game_id: game.id, x_position: 3, y_position: 6, color: true)}

    it 'should delete target piece and move current piece to that position ' do
      king.capture(5,6) # Capture position of opponent piece
      expect(king.x_position).to eq(5) # Expect current piece to move to that position
      expect(king.y_position).to eq(6) # Expect current piece to move to that position
      expect(ChessPiece.find_by(id: capture_pawn.id)).to be_nil

    end

    it 'should do nothing if there is no opponent piece' do
      king.capture(6,6)
      expect(king.x_position).to eq(4)
      expect(king.y_position).to eq(6)
    end

    it 'should do nothing if the piece you are trying to capture is the same color' do
      # binding.pry
      king.capture(3,6)
      expect(king.x_position).to eq(4)
      expect(king.y_position).to eq(6)
    end
  end
end
