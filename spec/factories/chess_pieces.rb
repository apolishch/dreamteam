FactoryBot.define do
  factory :chess_piece do
    association :game
  end
    
  factory :king do
    association :game
    x_position 4
    y_position 4
  end
end
