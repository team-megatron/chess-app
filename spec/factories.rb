FactoryGirl.define do
  factory :piece do
    game_id 1
    row 1
    column 1
    is_black true
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
