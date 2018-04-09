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

    if @piece.valid_move?(pieces_params[:x_position].to_i, pieces_params[:y_position].to_i)
      @piece.update_attributes(pieces_params)
      redirect_to game_path(@game)
    else
      redirect_to game_path(@game), alert: "Invalid Move!"
    end
  end

  private

  def pieces_params
    params.require(:chess_pieces).permit(:x_position, :y_position)
  end

end