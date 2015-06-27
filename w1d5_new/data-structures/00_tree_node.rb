# Matthew Skinner & Jesse Latimer

class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(val)
    if val.nil?
      @parent = val
    else
      parent.remove_child(self) if parent
      @parent = val
      parent.add_child(self) if parent
    end
  end

  def add_child(child)
    children << child unless children.include?(child)
    child.parent = self if child.parent != self
  end

  def remove_child(child)
    children.include?(child) ? child.parent = nil : raise("Not yo child.")
    children.delete(child)
  end

  def trace_path_back
    return [self.value] if self.parent.nil?
    parent.trace_path_back << self.value    
  end

  def dfs(target)
    return self if target == value

    children.each do |child|
      result = child.dfs(target)
      return result if result
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current = queue.shift
      return current if current.value == target
      queue += current.children
    end
    nil
  end

end
