module GamesHelper
  def select_html_symbol(piece)
    white_symbols = {'Rook'=> '&#9814;', 'Knight'=>'&#9816;', 'Bishop'=>'&#9815;',
                    'Queen'=> '&#9813;', 'King'  =>'&#9812;', 'Pawn'  =>'&#9817;'}
    black_symbols = {'Rook'=>'&#9820;', 'Knight' =>'&#9822;', 'Bishop'=>'&#9821;',
                    'Queen'=> '&#9819;', 'King'  =>'&#9818;', 'Pawn'  =>'&#9823;'}

    if piece
      return piece.is_black? ? black_symbols[piece.type] : white_symbols[piece.type]
    else
      return ''
    end
  end

  def square_color(row, col)
    return ((row + col) % 2 == 0) ? 'square white' : 'square black'
  end

  def piece_color(piece)
    return piece.is_black? ? 'black' : 'white'
  end

  def render_piece_in_square(row, col, piece)
    content_tag(
      :td,
      content_tag(:div, raw(select_html_symbol(piece)), data: { 'piece-color' => piece_color(piece), 'piece-type' => piece.type },
      class: 'contains-piece', id: "piece-#{piece.id}"),
      class: square_color(row, col),
      id: "square-#{row}-#{col}",
    )
  end

  def render_empty_square(row, col)
    content_tag(:td, '', class: square_color(row, col), id: "square-#{row}-#{col}")
  end
end
