require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :parent, :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos if prev_move_pos
    @parent = nil
  end

  def losing_node?(evaluator)
    if board.over?
      return false if board.winner.nil? || board.winner == evaluator
      return true if board.winner != evaluator
    end

    if next_mover_mark == evaluator
      if self.children.all? { |child| child.losing_node?(evaluator) }
        return true
      end
    else
      self.children.each do |child|
        return true if child.losing_node?(evaluator)
      end
    end
    false
  end

  def winning_node?(evaluator)
    if board.over?
      return true if board.winner == evaluator
      return false
    end

    if next_mover_mark == evaluator
      self.children.each do |child|
        return true if child.winning_node?(evaluator)
      end
    else
      if self.children.all? { |child| child.winning_node?(evaluator) }
        return true
      end
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    building_children = [] # creepy
    board.rows.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        if tile.nil?
          current_board = board.dup
          current_board[[i, j]] = @next_mover_mark
          next_mark = @next_mover_mark == :x ? :o : :x
          building_children << TicTacToeNode.new(current_board, next_mark, [i, j])
        end
      end
    end
    building_children
  end
end
