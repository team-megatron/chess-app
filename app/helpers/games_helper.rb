module GamesHelper
  def select_html_symbol(piece_type, color)
    white_symbols = {'Rook'=> '&#9814;', 'Knight'=>'&#9816;', 'Bishop'=>'&#9815;',
                    'Queen'=> '&#9813;', 'King'  =>'&#9812;', 'Pawn'  =>'&#9817;'}
    black_symbols = {'Rook'=>'&#9820;', 'Knight' =>'&#9822;', 'Bishop'=>'&#9821;',
                    'Queen'=> '&#9819;', 'King'  =>'&#9818;', 'Pawn'  =>'&#9823;'}

    color == 'black' ? black_symbols[piece_type] : white_symbols[piece_type]
  end
end
