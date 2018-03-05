class GamesController < ApplicationController	
  before_action :authenticate_user!, only: [:show, :new, :create]

  def index	
    @games = Game.all
    
  end	

  def show
    @game = Game.find_by_id(params[:id])
    if @game.blank?
      render plain: 'Not Found :(', status: :not_found
    end
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)
    if @game.valid?
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:game_name)
  end
end


