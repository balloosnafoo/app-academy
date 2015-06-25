require_relative 'tile'

class Board
  attr_reader :tiles

  def initialize
    @tiles = Array.new
    populate
  end

  def populate
    group = 0
    3.times do |i|
      3.times do |j|
        3.times do |row|
          3.times { |column| @tiles << Tile.new(i*3 + row, j*3 + column, group) }
        end
      end
      group += 1
    end
  end

  def self.import_board(filename)
    board = Board.new
    f = File.readlines(filename).map(&:chomp)
    f.each_with_index do |row, i|
      row.split("").each_with_index do |value, j|
        if value != "0"
          board[i, j] = value
          board[i, j].given = true
        end
      end
    end
    board
  end

  def []=(row, column, value)
    @tiles.find{ |el| el.in_row?(row) & el.in_column?(column) }.value = value
  end

  def [](row, column)
    @tiles.find{ |el| el.in_row?(row) & el.in_column?(column) }
  end

  def render
    9.times do |row|
      string = ""
      puts "-" * 31 if row % 3 == 0
      9.times do |column|
        string += "|" if column % 3 == 0
        string += " #{self[row, column].to_s} "
      end
      puts string + "|"
    end
    puts "-" * 31
  end

  def complete?
    @tiles.select { |tile| tile.value }.length == 81
  end


  def valid?
    (0..9).each do |index|
      return false if !(check_row(index) && check_column(index) && check_group(index))
    end
    true
  end

  def check_row(row)
    row = @tiles.select{ |el| el.in_row?(row) }.map{ |tile| tile.value }
    row.each do |value|
      return false if row.count(value) > 1 && value != nil
    end
    true
  end

  def check_column(column)
    column = @tiles.select{ |el| el.in_column?(column) }.map{ |tile| tile.value }
    column.each do |value|
      return false if column.count(value) > 1 && value != nil
    end
    true
  end

  def check_group(group)
    group = @tiles.select{ |el| el.in_row?(group) }.map{ |tile| tile.value }
    group.each do |value|
      return false if group.count(value) > 1 && value != nil
    end
    true
  end

end

# b.element(0,0).class
# puts b.element(0,0)
