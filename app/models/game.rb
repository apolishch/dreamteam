class Game < ApplicationRecord
  belongs_to :user
  validates :game_name, presence: true
end
