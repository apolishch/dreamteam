class PiecesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]
  # require 'pry';


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

    original_x = @piece.x_position
    original_y = @piece.y_position

    @piece.update_attributes(pieces_params)
    create_move(original_x, original_y)
    if @piece.valid?
     redirect_to game_path(@game)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create_move(x, y)
    @move = Move.new(game_id: @game.id, chess_piece_id: @piece.id, x_position: x, y_position: y, new_x_position: @piece.x_position, new_y_position: @piece.y_position)
    # binding.pry
    @move.save!
  end

  private

  def pieces_params
    params.permit(:x_position, :y_position, moves_attributes:[:moves_game_id, :moves_chess_piece_id, :moves_count])
  end

end
