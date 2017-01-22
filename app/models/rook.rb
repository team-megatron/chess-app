class Rook < Piece
  
  def valid_move?(row_destination, col_destination)
    row_diff = (self.row - row_destination).abs
    col_diff = (self.column - col_destination).abs
    
    #horizontal
    if row_diff == 0 && col_diff > 0
      return true
    #vertical
    elsif row_diff > 0 && col_diff == 0
      return true
    else
      return false
    end
  end
 
end
