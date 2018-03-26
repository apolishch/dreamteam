FactoryBot.define do
  factory :chess_piece do
    association :game
    association :pawn

  end

  factory :pawn do
    association :game
    association :chess_piece
  end
end
