require_relative "board"

class Game
  attr_accessor :board

  def initialize(filename)
    @board = Board.import_board(filename)
  end

  def play
    board.render
    until won?
      pos = get_pos
      value = get_value
      until valid?(pos, value)
        puts "Invalid!"
        pos = get_pos
        value = get_value
      end
      @board[*pos] = value
      board.render
    end

    puts "won"

  end

  def valid?(pos, value)
    return false if !(0..8).include?(pos[0]) || !(0..8).include?(pos[1]) || @board[*pos].given
    return false if !(1..9).include?(value.to_i)
    true
  end

  def won?
    @board.complete? && @board.valid?
  end

  def get_pos
    puts "Which position to change?"
    gets.chomp.split(", ").map(&:to_i)
  end

  def get_value
    puts "Which value to change to?"
    gets.chomp
  end


end

filename = ARGV.shift
g = Game.new(filename)
g.play
