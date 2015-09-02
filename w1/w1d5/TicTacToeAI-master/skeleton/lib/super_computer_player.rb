require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    tic_tac_toe = TicTacToeNode.new(game.board,mark)
    not_losing_moves = []
    tic_tac_toe.children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
      not_losing_moves << child.prev_move_pos if !child.losing_node?(mark)
    end
    raise "No Non-losing Nodes" if not_losing_moves.empty?
    not_losing_moves.sample
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
