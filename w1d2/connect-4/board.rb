require "colorize"

class Board

  attr_reader :columns

  def initialize
    @columns = Array.new(7) { Array.new(6) }
  end

  def check_subgrid(anchor)
    (rows(anchor) + cols(anchor) + diagonals(anchor)).each do |strip|
      return true if strip == [:red] * 4 || strip == [:black] * 4
    end
    false
  end

  def win?
    (0...4).each do |i|
      (0...3).each { |j| return true if check_subgrid([i, j])}
    end
    false
  end

  def drop_piece(col, symbol)
    @columns[col].each_with_index do |cell, row|
      if cell.nil?
        self[[col, row]] = symbol
        break
      end
    end
  end

  def display
    board = transpose
    board.reverse.each do |row|
      row.each do |piece|
        print "|"
        print !piece.nil? ? "O".colorize(piece) : " "
        print "|"
      end
      puts
    end
  end

  #First position => col, Second position => row
  def [](pos)
    col, row = pos
    columns[col][row]
  end

  def []=(pos, value)
    col, row = pos
    columns[col][row] = value
  end

  #private

  def cols(anchor)
    start_column = anchor[0]
    start_row = anchor[1]
    @columns[start_column...start_column + 4].map { |col| col[start_row...start_row + 4]}
  end

  def transpose
    transposed = Array.new

    (0...6).each do |row|
      rows = Array.new
      (0...7).each do |col|
        rows << self[[col, row]]
      end
      transposed << rows
    end
    transposed
  end

  def rows(anchor)
    @rows = transpose
    start_row = anchor[1]
    start_column = anchor[0]
    @rows[start_row...start_row + 4].map { |row| row[start_column...start_column + 4] }
  end

  def diagonals(anchor)
    start_column = anchor[0]
    start_row = anchor[1]

    #down_diagonal = (start_column...start_column + 4).map { |idx| self[[idx, idx]] }
    #up_diagonal = (start_column...start_column + 4).map { |idx| self[[idx, 3-idx]] }
    #[down_diagonal, up_diagonal]

    down_diagonal = []
    (0..3).each do |index|
      down_diagonal << self[[start_column + index, start_row + index]]
    end

    up_diagonal = []
    (0..3).each do |index|
      up_diagonal << self[[start_column + 3 - index, start_row + index]]
    end

    [down_diagonal, up_diagonal]

  end


end

b = Board.new
(0..4).each do |index|
  b.drop_piece(index, :red)
end
puts b.win?
