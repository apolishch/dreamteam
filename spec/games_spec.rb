require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe "games#show action" do

    it "should require users to be logged in" do
      game = FactoryBot.create(:game)
      get :show, params: { id: game.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the page if the game is found" do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game)
      get :show, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the game is not found" do
      user = FactoryBot.create(:user)
      sign_in user
      get :show, params: { id: 'KWANZAA' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "games#index action" do

    it "should successfully show the root page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#new action" do

    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new page" do
      user = FactoryBot.create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end


  end

  describe "games#create action" do

     it "should require users to be logged in" do
      post :create, params: { game: { game_name: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new game in our database" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { game: { game_name: 'Hello!' } }
      gameid = Game.last.id
      expect(response).to redirect_to game_path(gameid)

      game = Game.last
      expect(game.game_name).to eq("Hello!")
      expect(game.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user

      game_count = Game.count
      post :create, params: { game: { game_name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(game_count).to eq Game.count
    end
  end

  describe 'games#update action' do

    context "if user tries to join his own created game" do
      before :each do
        @user = FactoryBot.create(:user, id: 3)
        sign_in @user
        @game = FactoryBot.create(:game, user_id: 3, opponent_id: nil)
        patch :update, id: @game.id, game: { user_id: 3, opponent_id: 3 }
      end

      it "should redirect to game" do
        expect(response).to redirect_to game_path(@game)
      end

      it "ensure that opponent is not updated" do
        expect(@game.opponent_id).to eq(nil)
      end
    end

    context "If user tries to join someone else's game" do
      before :each do
        @user = FactoryBot.create(:user, id: 5)
        sign_in @user
        @user1 = FactoryBot.create(:user, id: 1)
        sign_in @user1
        @game = FactoryBot.create(:game, user_id: @user.id, opponent_id: nil)
        patch :update, id: @game.id, game: { opponent_id: @user1.id }
      end

      it "should redirect_to game" do
        expect(response).to redirect_to game_path(@game)
      end

      it "should update opponent, not game user" do
        expect(@game.user_id).to eq(5)
        expect(@game.opponent_id).to eq(1)
      end
    end

  end

end
