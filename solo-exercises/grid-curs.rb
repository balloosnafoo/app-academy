# This was an exercise that I did to try and improve on the UI of the games that we
# have been making. It gets tedious figuring out which spot you want on a zero indexed
# grid where [0, 0] is the top left

require "colorize"

class Board

  attr_reader :cursor

  def initialize
    @grid = Array.new(5){ Array.new(5) { "X" } }
    @cursor = [0, 0]
  end

  def render
    system("clear")
    @grid.each_with_index do |_, row|
      _.each_with_index do |_, col|
        print " #{cursor?(row, col) ? self[row, col].colorize(:green) : self[row, col]} "
      end
      puts
    end
  end

  def [](row, col)
    @grid[row][col]
  end

  # This would be in the Game class if integrated into a whole game.
  def run
    render
    loop do
      commands = get_input
      return if commands[0] == "quit"
      handle_input(commands)
      render
    end
  end

  # All commands are separated by commas
  # Movement commands follow this pattern /\d\w/ , e.g. "1u, 2l" => 1 up, 2 left
  def get_input
    puts "Input command: "
    gets.chomp.split(",").map(&:strip)
  end

  def handle_input(commands)
    commands.each do |command|
      if /\d\w/ =~ command
        move_cursor(command)
      end
    end
  end

  def cursor?(row, col)
    return @cursor == [row, col]
  end

  def move_cursor(info)
    spots, direction = info.split("")
    spots = spots.to_i
    case direction
    when "u"
      cursor[0] -= spots if (cursor[0] - spots).between?(0, grid.size)
    when "d"
      cursor[0] += spots if (cursor[0] + spots).between?(0, grid.size)
    when "l"
      cursor[1] -= spots if (cursor[1] - spots).between?(0, grid.size)
    when "r"
      cursor[1] += spots if (cursor[1] + spots).between?(0, grid.size)
    end
    puts "Cursor #{cursor}"
  end

  private
  attr_reader :grid

end
