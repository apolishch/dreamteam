require 'rails_helper'

RSpec.describe GamesController, type: :controller do
    
    describe '#forfeit_game' do
        let!(:user) {FactoryBot.create(:user, wins: 0, losses: 0)}
        let!(:opponent) {FactoryBot.create(:user, wins: 0, losses: 0)}
        let!(:current_user) {FactoryBot.create(:user, wins: 0, losses: 0)}
        let!(:game) {FactoryBot.create(:game, game_name: "test_game", user_id: current_user.id , opponent_id: opponent.id)}
        
        
        xit 'shouldn\'t set the game\'s winnner if the user isn\'t one of the players' do
            params = { id: game.id, game: { user_id: user.id } }
            
            
            sign_in opponent
            sign_in current_user

            
            patch :forfeit, params: params
            game.reload
            
            # puts user.inspect
            # puts current_user.inspect
            
            expect(game.winner_id).to eq(nil)
            
            
            
        end
        
        it 'ends the game' do
            params = { id: game.id }
            
            sign_in current_user
            sign_in opponent
            
            patch :forfeit, params: params
            game.reload
            expect(game.status).to eq("complete")
        end
        
        xit 'updates the winner\'s record to reflect the win' do
            params = { id: game.id }
            
            sign_in current_user
            sign_in opponent
            
            # puts game.inspect
            # puts opponent.inspect
            
            patch :forfeit, params: params
            game.reload
            opponent.reload
            # puts game.inspect
            # puts opponent.inspect
            expect(opponent.wins).to eq(1)
        end
        
        xit 'updates the loser\'s record to reflect the loss' do
            params = { id: game.id }
            
            sign_in opponent
            sign_in current_user
            
            patch :forfeit, params: params
            game.reload
            current_user.reload
            
            expect(current_user.losses).to eq(1)
        end
    end
    
end