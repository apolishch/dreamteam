require 'rails_helper'

RSpec.describe GamesController, type: :controller do
    
    describe '#forfeit_game' do
        let!(:user) {FactoryBot.create(:user, id: 1, wins: 0, losses: 0)}
        let!(:opponent) {FactoryBot.create(:user, id: 2, wins: 0, losses: 0)}
        let!(:game) {FactoryBot.create(:game, id: 10, game_name: "test_game", user_id: 1, opponent_id: 2)}
        
        
        xit 'should require the user to be one of the players in the game' do
            sign_in user
            sign_in opponent
            patch :forfeit_game, params: { game: { winner_id: 3 } }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(game.winner_id).to eq(nil)
        end
        
        xit 'updates the game\'s winner attribute with the user id of the user that didn\'t forfeit' do
            sign_in user
            sign_in opponent
            patch :forfeit_game, params: { game: { winner_id: game.user_id } }
        end
        
        xit 'ends the game' do
            sign_in user
            sign_in opponent
            patch :forfeit_game, params: { game: { winner_id: game.user_id } }
            expect(game.is_active?).to eq(false)
        end
        
        xit 'updates the winner\'s record to reflect the win' do
            sign_in user
            sign_in opponent
            patch :forfeit_game, params: { game: { winner_id: game.user_id } }
            expect(user.wins).to eq(1)
        end
        
        xit 'updates the loser\'s record to reflect the loss' do
            sign_in user
            sign_in opponent
            patch :forfeit_game, params: { game: { winner_id: game.user_id } }
            expect(opponent.losses).to eq(1)
        end
    end
    
end