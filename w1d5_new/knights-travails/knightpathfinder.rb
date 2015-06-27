require_relative '../data-structures/00_tree_node.rb'
require 'set'
require 'byebug'

class KnightPathFinder

  attr_reader :visited_positions, :starting_pos

  def self.valid_moves(pos)
    positions = []
    [-1, 1].each do |i|
      [-2, 2].each do |j|
        position = [pos[0] + i, pos[1] + j]
        positions << position if on_board?(position)
        position = [pos[0] + j, pos[1] + i]
        positions << position if on_board?(position)
      end
    end
    positions
  end

  def self.on_board?(pos)
    return false unless pos[0].between?(0, 7)
    return false unless pos[1].between?(0, 7)
    true
  end

  def initialize(starting_pos)
    @starting_pos = starting_pos
    @visited_positions = Set.new
    @move_tree = build_move_tree
  end

  def find_path(end_pos)
    @move_tree.dfs(end_pos).trace_path_back
  end

  def build_move_tree
    root = PolyTreeNode.new(starting_pos)
    tiles = [root]
    until tiles.empty?
      current_tile = tiles.shift
      new_move_positions(current_tile.value).each do |pos|
        child_tile = PolyTreeNode.new(pos)
        current_tile.add_child(child_tile)
        tiles << child_tile
      end
    end
    root
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    moves.select! { |move| !visited_positions.include?(move) }
    @visited_positions += moves
    moves
  end


end
