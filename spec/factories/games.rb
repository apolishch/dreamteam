FactoryBot.define do
  factory :game do
    game_name "hi"
    opponent_id nil
    association :user
  end
end
