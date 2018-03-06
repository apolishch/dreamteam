class Piece

  def initialize(name, color, rank)
    @name = name
    @color = color
    @rank = rank
  end3

end










class User
has_many :games

# create game
# join game


end

class Game
belongs_to :user
has_many :users, :games
end

class Piece
belongs_to :game
has_many :moves
end

class Move
belongs_to :piece
end









board has many players
game has many pieces
player has many pieces








# class Board
# belongs_to :game
# has_many :colors
# end

# class Color
# belongs_to :board
# has_many :pieces
# end


# class Winning_move
# belongs_to :move
# end
