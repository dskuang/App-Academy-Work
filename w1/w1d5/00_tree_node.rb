class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @value, @parent, @children = value, nil, []
  end

  def parent=(node)
    @parent.remove_child(self) if @parent && @parent.children.include?(self)
    @parent = node
    node.add_child(self) if node && !node.children.include?(self)
  end

  def add_child(node)
    @children << node
    node.parent = self unless node.parent == self
  end

  def remove_child(node)
    raise "This node is not a child!" unless @children.include?(node)
    @children.delete(node)
    node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      results = child.dfs(target_value)
      return results if results
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue.concat(current_node.children)
    end
    nil
  end

  def trace_path_back
    node = self
    path = [self.value]
    while node.parent
      node = node.parent
      path << node.value
    end
    path.reverse
  end
end
