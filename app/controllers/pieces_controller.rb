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
    @move = @piece.moves.all

    @piece.update_attributes(pieces_params)
    update_moves
    if @piece.valid?
     redirect_to game_path(@game)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_moves
    puts "The piece has been updated dudes!"
    @piece = ChessPiece.find(params[:id])
    @piece.moves.update(count: 19991)
    @piece.save
    puts @piece.moves.count
  end

  private

  def pieces_params
    params.permit(:x_position, :y_position, moves_attributes:[:moves_game_id, :moves_chess_piece_id, :moves_count])
  end

end
