require 'rails_helper'

RSpec.describe Move, type: :model do

  describe '#valid_move?' do
    let(:game) {FactoryBot.create(:game)}
    let(:piece) {FactoryBot.create(:chess_piece, game_id: game.id, x_position: 4, y_position: 4)}

    it "text" do

    end
  end

end
