class Player

  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def get_move
    print "Enter column: "
    gets.chomp.to_i
  end
  
end
