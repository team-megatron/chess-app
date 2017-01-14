class Game < ActiveRecord::Base
  has_many :moves
  has_many :pieces
  belongs_to :white_player, class_name: 'Player'
  belongs_to :black_player, class_name: 'Player'

  def populate_game!
    8.times do |n|
      game.pieces.create(type: 'Pawn', row: 2, column: n)
    end
  end
end
