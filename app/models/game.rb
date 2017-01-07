class Game < ActiveRecord::Base
  has_many :moves
  belongs_to :white_player
  belongs_to :black_player
end
