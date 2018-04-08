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


  private

  def update_board
    @game = Game.find_by_id(params[:id])
    @game.save
  
  end

  def update_moves
    @game = Game.find_by_id(params[:id])
    @game.chess_pieces.update_attributes()
    end
  end

  def update_moves
    Move.create(type: @chess_piece.type, x_position: @chess_piece.x_position, y_position: @chess_piece.y_position, game_id: @game.id)
  end

  def game_params
    params.require(:game).permit(:game_name, :opponent_id)
  end
end
