class Tile
  NEIGHBORS = [
    [-1, 0],
    [1, 0],
    [0, 1],
    [0, -1],
    [1, 1],
    [-1, 1],
    [-1, -1],
    [1, -1]
  ]

  attr_accessor :bombed, :flagged, :revealed, :label
  attr_reader :pos
  def initialize(board, pos)
      @board = board
      @pos = pos
      @label = "~"
  end

  def flag
    @flagged = true
  end

  def bomb
    @bombed = true
  end

  def reveal_bombs(num_bombs)
    @revealed = true
    @flagged = false
    @label = num_bombs > 0 ? num_bombs : "."
  end

  def flagged?
    @flagged
  end

  def bombed?
    @bombed
  end

  def revealed?
    @revealed
  end

  def reveal
    return if revealed
    num_adjacent_bombs = adjacent_bombs
    reveal_bombs(num_adjacent_bombs)
    return if num_adjacent_bombs > 0 || bombed?
    valid_neighbors.each { |neighbor| neighbor.reveal }
  end

  def valid_neighbors
    neighbors = NEIGHBORS.map { |offset| [offset[0] + pos[0], offset[1] + pos[1]] }
    neighbors.select { |pos| pos.all? {|coord| coord.between?(0, 8) }}.map { |pos| @board[pos] }
  end

  def adjacent_bombs
    valid_neighbors.inject(0) { |num_bombs, tile| num_bombs + (tile.bombed? ? 1 : 0) }
  end

end
