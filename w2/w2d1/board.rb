require_relative "tile.rb"
require "set"



class Board
  attr_accessor :grid, :visited_positions, :bombs

  def initialize
    @grid = Array.new(9) { Array.new(9) }
    populate
    place_bombs
  end

  def blank?
    @grid.flatten.none?(&:revealed?)
  end

  def populate
    9.times do |i|
      9.times do |j|
        self[[i,j]] = Tile.new(self, [i,j])
      end
    end
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos,value)
    @grid[pos[0]][pos[1]] = value
  end

  def place_bombs
    places = Set.new
    until places.size == 10
      places << [rand(9),rand(9)]
    end
    places.each do |pos|
      self[pos].bomb
    end
  end

  def flag(pos)
    self[pos].flag
  end

  def column_headings
    puts
    print "    "
    9.times { |i| print i.to_s + " " }
    puts puts
  end

  def render
    column_headings
    @grid.each_with_index do |row,idx|
      puts idx.to_s + "   " + row.map { |tile| tile.flagged? ? "F" : tile.label }.join(" ")
    end
    puts
  end

  def render_all
    column_headings
    @grid.each_with_index do |row, idx|
      puts idx.to_s + "   " + row.map { |tile| tile.bombed? ? "x" : tile.label }.join(" ")
    end
    puts
  end

  def over?
    lose? || won?
  end

  def lose?
    @grid.flatten.select(&:bombed?).any?(&:revealed?)
  end

  def won?
    @grid.flatten.reject(&:bombed?).all?(&:revealed?)
  end
end


# b = Board.new
# b.reveal_all([3,3])
# #p b
# b.render
