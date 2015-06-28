require "colorize"

class Tile

  attr_accessor :value, :given, :color

  def initialize(value = nil, given = false)
    @value = value
    @given = given
    @color = given ? :green : :white
  end

  def to_s
    @value || " "
  end

  def ==(other_tile)
    return true if other_tile.value == @value
    false
  end

end
