FactoryBot.define do
  factory :chess_piece do
    association :game
  end

  factory :pawn do
    association :game
  end
end
