FactoryBot.define do
  factory :chess_piece do
    association :game
  end

  factory :pawn do
    association :game
  end

  factory :king do
    association :game
    x_position 4
    y_position 4
  end


  factory :rook do
  end

  factory :bishop do
  end

  factory :knight do
  end

  factory :queen do
  end

end
