#require_relative 'tile.rb'
require_relative 'board.rb'
require 'yaml'


class Minesweeper
  attr_accessor :board, :loaded

  def initialize
    @board = Board.new
    load_if_necessary
  end

  def load_if_necessary
    @loaded = to_load?
    if @loaded
      f = File.open("minesweeper.yaml")
      @board = YAML::load(f)
      File.delete("minesweeper.yaml")
    end
  end

  def to_load?
    return false unless File.exists?("minesweeper.yaml")
    p "Continue? (y/n)"
    gets.chomp == "y"
  end

  def save_if_necessary
    if to_save?
      File.open("minesweeper.yaml","w") do |f|
        f.puts @board.to_yaml
      end
      exit
    end
  end

  def to_save?
    p "Do you wish to save? (y/n)"
    gets.chomp == "y"
  end

  def run
    @board.render
    until @board.over?
      save_if_necessary unless @board.blank? || @loaded
      values = get_values
      place_marker(values)
      @board.render
      @loaded = false
    end
    puts @board.won? ? "You Win!" : "You Lose!"
    @board.render_all
  end

  def get_values
    input = nil
    is_valid = nil
    prompt
    until input && is_valid
      input = gets.chomp
      is_valid = is_valid?(input)
      puts "Enter a VALID position" unless is_valid
    end
    input
  end

  def prompt
    puts "Enter a position and revealed/flagged ex. 3 4 r"
  end

  def is_valid?(input)
    vals = input.split(" ")
    begin
      row, col = Integer(vals[0]), Integer(vals[1])

      vals.length == 3 && row.between?(0,8) && col.between?(0,8)\
       && (vals[2].downcase == "r" || vals[2].downcase == "f")\
       && !@board[[row,col]].revealed?

    rescue
      false
    end
  end

  def place_marker(input_str)
    input = input_str.split(" ")
    if input[2] == "r"
      @board[[input[0].to_i,input[1].to_i]].reveal
    else
      @board[[input[0].to_i,input[1].to_i]].flag
    end
  end


end

m = Minesweeper.new
m.run
