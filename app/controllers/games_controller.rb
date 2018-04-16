class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create]

  def home
  end

  def index
    @games = Game.where.not(:opponent_id => nil)
    @singleplayer = Game.where(:opponent_id => nil)
  end

  def show
    @game = Game.find_by_id(params[:id])
    puts @game
    if @game.blank?
      render plain: 'Not Found :(', status: :not_found
    end
  end

  def update
    @game = Game.find_by_id(params[:id])
    if current_user.id == @game.user_id
      flash[:notice] = "Welcome back. Your game is awaiting."
      redirect_to game_path(@game)
    elsif @game.opponent_id.nil?
      @game.update_attributes(opponent_id: current_user.id)
      redirect_to game_path(@game)
    else
      render plain: 'Couldn\'t join the game. Please try another game', status: :unprocessable_entity
    end
  end


  def new
    @game = Game.new

  end

  def create
    @game = current_user.games.create(game_params)
    if @game.valid?
      @game.populate_board

      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def forfeit
    @game = Game.find_by_id(params[:id])
    if current_user.is_player_in_game?(current_user, @game)
      current_user.forfeits(@game)
      puts @game.inspect
      puts current_user.inspect
      puts User.find_by_id(@game.opponent_id).inspect
    else
      render :plain, "It doesn't look like you are a player in this game. Please go back and try something else."
    end
  end

  private

  def game_params
    params.require(:game).permit(:game_name, :opponent_id, :winner_id)
  end
end
