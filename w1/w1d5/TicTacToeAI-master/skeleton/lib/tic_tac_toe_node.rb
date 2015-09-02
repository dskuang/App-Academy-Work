require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      @board.winner && @board.winner != evaluator
    elsif @next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      @board.winner == evaluator
    elsif @next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # Generates an array of all moves that can be made after the current move.
  def children
    child_array = []
    (0..2).each do |row|
      (0..2).each do |col|
        next unless @board.empty?([row, col])
        new_board = @board.dup
        new_board[[row, col]] = next_mover_mark
        next_mover_mark == :x ? new_mark = :o : new_mark = :x
        child_array << TicTacToeNode.new(new_board, new_mark, [row, col])
      end
    end

    child_array
  end
end
