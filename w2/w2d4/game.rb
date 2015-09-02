class StartError < StandardError

end

load 'board.rb'
load 'player.rb'
require_relative 'king'

class Game
  attr_reader
  attr_accessor :board, :player1, :player2, :players, :start_pos, :end_pos, :double_jump

  RESTART = [999, 999]

  def initialize
    @board = Board.new
    @player1 = Player.new(board, "red")
    @player2 = Player.new(board, "blue")
    @players = [player1, player2]
    @start_pos, @end_pos = nil, nil
    @double_jump = false


  end


  def test
    board.seed_pieces

    @board.render(players.last.cursor)
      start_message
      backspace_message
      begin
        until won?
          @start_pos = get_start_move
          @end_pos = get_end_move
          raise StartError.new("#{players.first.color.capitalize} Starting Over!\
          ") if start_over?
          perform_slide_or_jump
          handle_double_jump
          set_new_king(end_pos) if check_king?(end_pos)
          set_cursor
          print_board
          backspace_message
          break if won?
          change_turn
        end
      rescue StartError => e
        puts e.message
        retry
      end
      puts "#{winner}"
  end


  private

  def start_over?
    if @end_pos == RESTART

      return true
    end
    false
  end

  def print_board
    @board.render(end_pos)
  end

  def set_cursor
    players.last.cursor = end_pos
  end

  def perform_slide_or_jump
    if board[start_pos].get_possible_sliding_moves.include?(end_pos)
      board[start_pos].perform_slide(end_pos)

    elsif board[start_pos].get_possible_jumping_moves.include?(end_pos)
      board[start_pos].perform_jump(end_pos)

      board[end_pos].has_multiple_jump? ? @double_jump = true : @double_jump = false
    end
  end

  def start_message
    puts "Welcome to Checkers"
    puts "#{@players.first.color.capitalize} Starts!"
  end

  def change_turn
    @players.rotate!
    puts "#{@players.first.color.capitalize}'s Turn"
  end

  def check_king?(pos)
     pos.first == 0 || pos.first == 7
  end

  def set_new_king(pos)
    board[pos] = King.new(board, pos, board[pos].color)
  end

  def handle_double_jump
    while @double_jump

      @start_pos = end_pos
      @end_pos = get_end_move
      board[start_pos].perform_jump(end_pos)
      @double_jump = false unless board[end_pos].has_multiple_jump?
    end
  end

  def won?
    get_pieces.none?{|x| x.color == "red"} || get_pieces.none?{|x| x.color == "blue"}
  end

  def winner
    get_pieces.none?{|piece| piece.color == "red"} ? "Blue Wins!" : "Red Wins!"
  end

  def get_pieces
    board.grid.flatten
  end

  def get_start_move
    @start_pos = players.first.move_cursor
    restart?
    until board[start_pos].color == players.first.color
      puts "Select Your Own Color"
      @start_pos = players.first.move_cursor
      restart?
    end
    start_pos
  end

  def backspace_message
    puts "Press Backspace to Deselect"
  end

  def restart?
    if start_pos == RESTART
      puts "#{players.first.color.capitalize} Starting Over!"
      get_start_move
    end
  end


  def get_end_move
    end_pos = players.first.move_cursor
    positions = get_all_positions << RESTART

      until positions.include?(end_pos)
        puts "Pick A Valid Position"
        end_pos = players.first.move_cursor
      end

    end_pos
  end

  def get_all_positions
    if double_jump
      positions = board[start_pos].get_possible_jumping_moves
    else
      positions = board[start_pos].get_possible_sliding_moves +
      board[start_pos].get_possible_jumping_moves
    end
  end

end

  g = Game.new
  g.test
