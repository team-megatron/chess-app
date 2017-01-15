class Game < ActiveRecord::Base
  has_many :moves
  has_many :pieces
  belongs_to :white_player, class_name: 'Player'
  belongs_to :black_player, class_name: 'Player'

  def populate_game!
    8.times do |n|
      self.pieces.create(type: 'Pawn', row: 2, is_black: false, column: n + 1)
      self.pieces.create(type: 'Pawn', row: 7, is_black: true, column: n + 1)
    end

    [1,8].each do |n|
      self.pieces.create(type: 'Rook', row: 1, is_black: false, column: n)
      self.pieces.create(type: 'Rook', row: 8, is_black: true, column: n)
    end

    [2,7].each do |n|
      self.pieces.create(type: 'Knight', row: 1, is_black: false, column: n)
      self.pieces.create(type: 'Knight', row: 8, is_black: true, column: n)
    end

    [3,7].each do |n|
      self.pieces.create(type: 'Bishop', row: 1, is_black: false, column: n)
      self.pieces.create(type: 'Bishop', row: 8, is_black: true, column: n)
    end

    self.pieces.create(type: 'Queen', row: 1, is_black: false, column: 4)
    self.pieces.create(type: 'Queen', row: 8, is_black: true, column: 4)
    self.pieces.create(type: 'King', row: 1, is_black: false, column: 5)
    self.pieces.create(type: 'King', row: 8, is_black: true, column: 5)
  end
end
