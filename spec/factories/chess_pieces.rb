FactoryBot.define do
  factory :chess_piece do
    association :game
  end

    
  factory :king do
  end


  factory :rook do  
    association :game
  end

  factory :bishop do  
  end

  factory :knight do  
  end

  factory :queen do  
  end

  factory :pawn do  

  end
end
