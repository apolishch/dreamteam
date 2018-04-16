class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :games
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def forfeits(game)
    self.add_loss
    self.find_opponent(game).add_win
    game.forfeit(self)
  end
  
  def find_opponent(game)
    players = User.where("id = ? OR id = ?", game.user_id, game.opponent_id).to_a
    opponent = players.find { |player| player.id != self.id }
    opponent
  end
  
  def add_loss
    losses = self.losses =+ 1
    self.update_attributes(losses: losses)
  end
  
  def add_win
    wins = self.wins =+ 1
    self.update_attributes(wins: wins)
  end
  
  def is_player_in_game?(user, game)
    user.id == game.user_id || game.opponent_id
  end
end
