class PiecesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]


  def show
    @current_piece = ChessPiece.find(params[:id])
    @game = Game.find_by_id(@current_piece.game_id)

    if @game.blank?
      render plain: 'Not Found :(', status: :not_found
    end
  end

  def update
    @piece = ChessPiece.find(params[:id])
    @game = Game.find_by_id(@piece.game_id)


    @piece.update_attributes(pieces_params)
    if @piece.valid?
     redirect_to game_path(@game)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def pieces_params
    params.permit(:x_position, :y_position)
  end

end
