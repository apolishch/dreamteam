class Move < ApplicationRecord
  belongs_to :game

  def count_move
    start = @game.created_at
    current_move = @game.updated_at
    i = 0

    while current_move > start do
      i += 1
    end

    @game.move.count.push(i)

  end

end
