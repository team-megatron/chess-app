FactoryGirl.define do
  factory :piece do
    game_id 1
    row 1
    column 1
    is_black true
  end

  types = [:king, :queen, :rook, :knight, :bishop, :pawn]
  types.each do |type|
    factory type do
      game_id 1
      row 1
      column 1
      is_black true
      type type.to_s.capitalize
      captured false
    end
  end

  factory :move do

  end

  factory :game do
    name 'test'
    white_player_id 1
    black_player_id 2
  end

  factory :player do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end
end
