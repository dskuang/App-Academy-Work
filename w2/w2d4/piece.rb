require_relative 'movement'

class Piece
  include Movement
  attr_reader :empty, :board, :color
  attr_accessor :pos, :king

  SLIDE_MOVE = [1, -1]
  JUMP_MOVE = [2, -2]

  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
    @empty = false

  end

  def empty?
    @empty
  end

  def to_s
    " \u26c0  ".colorize(color.to_sym)
  end


  def perform_slide(new_pos)
    pos = self.pos
    board[new_pos] = board[pos]
    board[new_pos].pos = new_pos
    board[pos] = EmptyPiece.new
  end

  def perform_jump(new_pos)
    i, j = self.pos
    board[new_pos] = board[[i, j]]
    board[new_pos].pos = new_pos
    board[[i, j]] = EmptyPiece.new
    board[[(new_pos.first + i)/2, (new_pos.last + j)/2]] = EmptyPiece.new
    @board.render(new_pos)

  end


  def has_multiple_jump?
    !get_possible_jumping_moves.empty?
  end

  def get_possible_sliding_moves
    available_moves = color == "red" ? get_sliding_moves(SLIDE_MOVE.last, pos, board) :
      get_sliding_moves(SLIDE_MOVE.first, pos, board)
    available_moves
  end


  def get_possible_jumping_moves
     available_moves = color == "red" ? get_jumping_moves(JUMP_MOVE.last, pos, board, color) :
      get_jumping_moves(JUMP_MOVE.first, pos, board, color)
     available_moves
  end



end
