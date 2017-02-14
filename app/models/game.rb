class Game < ActiveRecord::Base
  has_many :moves
  has_many :pieces
  belongs_to :white_player, class_name: 'Player'
  belongs_to :black_player, class_name: 'Player'

  def populate_game!
    8.times do |n|
      self.pieces.create(type: 'Pawn', row: 2, is_black: false, captured: false, column: n + 1)
      self.pieces.create(type: 'Pawn', row: 7, is_black: true, captured: false, column: n + 1)
    end

    [1,8].each do |n|
      self.pieces.create(type: 'Rook', row: 1, is_black: false, captured: false, column: n)
      self.pieces.create(type: 'Rook', row: 8, is_black: true, captured: false, column: n)
    end

    [2,7].each do |n|
      self.pieces.create(type: 'Knight', row: 1, is_black: false, captured: false, column: n)
      self.pieces.create(type: 'Knight', row: 8, is_black: true, captured: false, column: n)
    end

    [3,6].each do |n|
      self.pieces.create(type: 'Bishop', row: 1, is_black: false, captured: false, column: n)
      self.pieces.create(type: 'Bishop', row: 8, is_black: true, captured: false, column: n)
    end

    self.pieces.create(type: 'Queen', row: 1, is_black: false, captured: false, column: 4)
    self.pieces.create(type: 'Queen', row: 8, is_black: true, captured: false, column: 4)
    self.pieces.create(type: 'King', row: 1, is_black: false, captured: false, column: 5)
    self.pieces.create(type: 'King', row: 8, is_black: true, captured: false, column: 5)
  end

  # Determine if a player is currently in check.
  # Expects a boolean value to represent whos turn it currently is
  # true = black, white = false
  def player_in_check?(is_black)
    # Grabs active players king
    king = self.pieces.find_by(type: 'King', is_black: is_black)

    # Grab all opponent pieces
    opponent_pieces = self.pieces.active.where(is_black: !is_black)

    # Loop through each piece and check to see if they can make a
    # valid move to the active players king (aka check)
    opponent_pieces.each do |piece|
      if piece.valid_move?(king.row, king.column)
        return true
      end
    end

    # Return false if no opponent piece can move to active players
    # king
    return false
  end
  
  # returns true if any piece in this game has move to the same location 3 times
  def draw?
    #for every game scan through each active piece
    all_active_pieces = self.pieces.active
      
    all_active_pieces.each do |active_piece|
      counts = location_counts(active_piece)
      counts.each_pair do |key, value|
        if value >= 3
          return true
        end
      end
    end
    return false
  end
  
  def location_counts(piece)
    #returns a hash table of all the places the piece has been and how many times it has been there
    counts = Hash.new
    
    piece.moves.each do |move|
      key = "#{move.end_row}, #{move.end_column}"
      counts[key]
      if counts[key] == nil
        counts[key] = 1
      else
        counts[key] += 1
      end
    end
    return counts
  end
end
