require_relative 'movement'
require_relative 'piece'

class King < Piece
  include Movement

  def to_s
    " \u26c1  ".colorize(color.to_sym)
  end

  def get_possible_sliding_moves
     available_moves = get_sliding_moves(SLIDE_MOVE.last, pos, board) +
     get_sliding_moves(SLIDE_MOVE.first, pos, board)

     available_moves
  end

  def get_possible_jumping_moves
     available_moves = get_jumping_moves(JUMP_MOVE.last, pos, board, color) +
     get_jumping_moves(JUMP_MOVE.first, pos, board, color)

     available_moves
  end

end
