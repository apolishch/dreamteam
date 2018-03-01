class Board < ApplicationRecord
  attr_accessor
  serialize :board_game, Array

  def initialize
    @board_game = []
  end

  def build_board
    letters = [ "a", "b", "c", "d", "e", "f", "g", "h" ]
    numbers = [ "1", "2", "3", "4", "5", "6", "7", "8" ]

    # board_game[0]["a1"]
    # => we want
    # [ 
    # {
    # "a1"=> ""
    # "b1"=> ""
    # "c1"=> ""
    #  ...
    # "h1" => ""
    # }  
    # ]
    letters.each do |letter|
      numbers.each do |number|
        @board_game << {"#{letter}#{number}" => ""}
      end
    end
  end
end