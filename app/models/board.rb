class Board < ApplicationRecord
  attr_accessor
  serialize :board_game, Array

  def initialize

  end


end
