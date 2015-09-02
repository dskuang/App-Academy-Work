require_relative "00_tree_node"

class KnightPathFinder
  def initialize start_position
    @start_pos = PolyTreeNode.new(start_position)
    @visited_positions = [@start_pos]
    build_move_tree
  end

  def find_path end_pos
    @start_pos.bfs(end_pos).trace_path_back
  end

  def new_move_positions pos
    new_positions = self.class.valid_moves(pos).select do |move|
      @visited_positions.all? { |node| node.value != move.value }
    end
    @visited_positions += new_positions

    new_positions
  end

  def build_move_tree
    queue = [@start_pos]
    until queue.empty?
      current_node = queue.shift
      queue.concat(new_move_positions(current_node))
    end
  end

  def self.valid_moves pos
    x, y = pos.value
    moves, amts = [], [2, 1, -2, -1]

    (0..3).each do |i|
      moves << [x + amts[i], y+amts[i-1]]
      moves << [x + amts[i], y+amts[i-3]]
    end

    moves.select do |move|
      (0..7).include?(move[0]) && (0..7).include?(move[1])
    end.map do |move|
      node = PolyTreeNode.new(move)
      node.parent = pos
      node
    end
  end
end
