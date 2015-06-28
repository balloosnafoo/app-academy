require_relative "tile"

class Board

  ANCHORS = {
    0 => [0, 0],
    1 => [0, 3],
    2 => [0, 6],
    3 => [3, 0],
    4 => [3, 3],
    5 => [3, 6],
    6 => [6, 0],
    7 => [6, 3],
    8 => [6, 6],
  }

  def initialize
    @board = Array.new(9) { Array.new (9) }
  end

  def get_row(index)
    @board[index]
  end

  def get_column(index)
    transposed = @board.transpose
    transposed[index]
  end

  def get_group(index)
    elements = []
    row_anchor, col_anchor = ANCHORS[index]
    (row_anchor..row_anchor + 2).each do |row|
      (col_anchor..col_anchor + 2).each do |col|
        elements << self[[row, col]]
      end
    end
    elements
  end

  def self.import_board(filename)
    board = Board.new
    f = File.readlines(filename).map(&:chomp)
    f.each_with_index do |row, i|
      row.split("").each_with_index do |value, j|
        if value != "0"
          board[[i, j]] = Tile.new(value, true)
        else
          board[[i, j]] = Tile.new
        end
      end
    end
    board
  end

  def gather
    subsets = []
    (0...9).each do |index|
      subsets << get_row(index)
      subsets << get_column(index)
      subsets << get_group(index)
    end
    subsets
  end

  def valid?
    gather.each { |subset| return false if duplicates?(subset) }
    true
  end

  def duplicates?(subset)
    subset.each do |value|
      return true if subset.count(value) > 1 && !value.nil?
    end
    false
  end

  def render
    system("clear")
    @board.each_with_index do |row, i|
      string = ""
      row.each_with_index do |el, j|
        string += "|" if j % 3 == 0
        string += " #{el.to_s.colorize(el.color)} "
      end
      puts "-" * 31 if i % 3 == 0
      puts string + "|"
    end
    puts "-" * 31
  end

  def complete?
    !@board.any? { |row| row.map{ |el| el.value }.compact.length < 9 }
  end

  def assign_value(pos, value)
    self[pos].value = value
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @board[row][col] = val
  end

end
