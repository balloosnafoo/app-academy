require_relative "card"

class Board
  attr_reader :grid, :size, :letter

  def initialize(num)
    @grid = blank_grid(num)
    @size = num
  end

  def populate
    (1).upto(size**2 / 2).to_a.each do |letter|
      2.times do
        row, col = rand(size), rand(size)
        row, col = rand(size), rand(size) until self[row, col].nil?
        self[row, col] = Card.new(letter)
      end
    end
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, letter)
    @grid[row][col] = letter
  end

  def render(turns)
    system("clear")
    lines = []
    @grid.each do |line|
      string = ""
      line.each { |card| string += "[%2s]" % card.to_s }
      lines << string
    end
    puts lines.join("\n")
    puts "You have #{turns} turns left."
  end

  def match?(pos1, pos2)
    self[*pos1] == self[*pos2]
  end

  def won?
    grid.each {|row| row.each { |column| return false if not column.revealed }}
    return true
  end

  private


  def blank_grid(num)
    Array.new(num) { Array.new(num) }
  end

end
