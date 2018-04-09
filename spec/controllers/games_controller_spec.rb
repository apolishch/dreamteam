require 'rails_helper'

RSpec.describe GamesController, type: :controller do
    
    describe '#forfeit_game' do
        let!(:user) {FactoryBot.create(:user, id: 1, wins: 0, losses: 0)}
        let!(:opponent) {FactoryBot.create(:user, id: 2, wins: 0, losses: 0)}
        let!(:game) {FactoryBot.create(:game, id: 10, game_name: "test_game", user_id: 1, opponent_id: 2, status: nil)}
        
        
        it 'shouldn\'t set the game\'s winnner if the user isn\'t one of the players' do
            sign_in user
            sign_in opponent
            patch :forfeit, params: { id: game.id, game: { winner_id: 3 } }
            expect(game.winner_id).to eq(nil)
        end
        
        it 'ends the game' do
            sign_in user
            sign_in opponent
            patch :forfeit, params: { id: game.id, game: { winner_id: game.user_id } }
            expect(game.status).to eq("complete")
        end
        
        it 'updates the winner\'s record to reflect the win' do
            sign_in user
            sign_in opponent
            patch :forfeit, params: { id: game.id, game: { winner_id: game.user_id } }
            expect(user.wins).to eq(1)
        end
        
        it 'updates the loser\'s record to reflect the loss' do
            sign_in user
            sign_in opponent
            patch :forfeit, params: { id: game.id, game: { winner_id: game.user_id } }
            expect(opponent.losses).to eq(1)
        end
    end
    
end