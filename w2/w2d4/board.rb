
require 'byebug'
require_relative "EmptyPiece"
require "colorize"
require_relative "piece"

class Board
  attr_accessor :move_array, :selected, :selected_moves, :double_jump
  attr_reader :grid


  def initialize
    @grid = Array.new(8){ Array.new(8) { EmptyPiece.new }}
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos,value)
    row, col = pos
    @grid[row][col] = value
  end

  def render(cursor)
    system("clear")

    puts "    0   1   2   3   4   5   6   7"
    @grid.each_with_index do |row, idx1|
      row_string = row.map.with_index do |piece, idx2|
      white, black = piece.to_s.colorize(:background => :white),
          piece.to_s.colorize(:background => :black)

        if [idx1, idx2] == cursor
          self[[idx1, idx2]].to_s.colorize(:background => :yellow)
        else
          idx1.even? ? (idx2.even? ? white : black):(idx2.even? ? black : white)
        end

      end
      puts "#{idx1.to_s}  #{row_string.join}"
    end
  end


  def seed_pieces
    (0..2).each {|row| seed_row(row, "blue")}
    (5..7).each {|row| seed_row(row, "red")}
  end

  def seed_row(row, color)
    @grid[row].each_index do |col|
      self[[row,col]] = Piece.new(self, [row,col], color) if row % 2 == col % 2
    end

  end

end
