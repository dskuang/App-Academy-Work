require_relative 'player.rb'
require 'set'
require_relative 'ghost_ai.rb'
require 'byebug'

class Game
attr_accessor :dictionary, :fragment, :losses
  def initialize(player1, player2, player3)
    @players = [player1, player2, player3]
    @fragment = ""
    @dictionary = read_dictionary
    @dict_set = Set.new(@dictionary)
    @losses = {@players[0] => 0, @players[1] => 0, @players[2] => 0}
  end

  def read_dictionary
    File.readlines("dictionary.txt").map(&:chomp)
  end

  def next_player
    @players.rotate!
  end

  def take_turn(player)
    player.receive_fragment(@fragment)
    letter = player.guess
    until valid_play? letter
      player.alert_invalid_guess
      letter = player.guess
    end
    @fragment << letter
  end

  def valid_play?(string)
    check1 = ("a".."z").include?(string) && string.length == 1
    check2 = dictionary.any? {|word| word.start_with?(@fragment + string) }
    check1 && check2
  end

  def lose_round?
    @dict_set.include? @fragment
  end

  def add_losses
    @losses[@players[0]] += 1
  end

  def lose?
    @losses.values.include?(3)

  end

  def remove_player
    player = @players[-1]
    @players.delete(@players[-1])
    @losses.delete(player)
  end

  def reset
    @fragment = ""
    puts "#{@players[0].name} loses the round!"
  end

  def last_man?
    @players.length == 1
  end

  def run
    until last_man?
      until lose?
        puts "#{@players[0].name}'s turn!'"

        take_turn(@players[0])
        if lose_round?
          reset
          add_losses
        end
        next_player
      end
      puts "#{@losses.key(3).name} loses!"
      remove_player
    end
    puts "#{@players[0].name} wins!"
  end


end


player3 = Ghost_Ai.new(3)
# player3.receive_fragment("aband")
# p player3.guess
player1 = Player.new("Jack")
player2 = Player.new("Jason")
g = Game.new(player1,player2,player3)
g.run
