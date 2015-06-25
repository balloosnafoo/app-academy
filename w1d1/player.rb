class Player
  #Maybe unnecessary class
end

class HumanPlayer < Player

  def initialize
  end

  def get_card(game)
    print "Pick a card: "
    gets.chomp.split(", ").map(&:to_i)
  end

end

class ComputerPlayer < Player
  attr_reader :board, :information

  def initialize
    @information = {}
    @previous_guesses = []
    @end_of_turn = false
  end

  def get_card(game)
    sleep(1)
    guess = matching_guess(game)
    puts "matching_guess: #{guess}"
    return guess ? guess : random_guess(game)
  end

  def random_guess(game)
    #puts "I'm in random guess"
    @previous_guesses = revealed_cards(game) if guessed_all_hidden?(game)
    limit = game.board_size
    pos = [ rand(limit), rand(limit) ]
    pos = [ rand(limit), rand(limit) ] until new_guess?(pos)
    #puts "random_guess: #{pos}"
    @previous_guesses << pos
    pos
  end

  def new_guess?(pos)
    !@previous_guesses.include?(pos)
  end

  def matching_guess(game)
    guess = nil
    p @information
    to_delete = nil
    information.each do |key, value|
      if value.length == 2
        guess = game.revealed?(value[0]) ? value[1] : value[0]
        to_delete = key
      end
    end
    puts "end of turn" if @end_of_turn
    information.delete(to_delete) if @end_of_turn && guess
    return guess
  end

  def guessed_all_hidden?(game)
    (0..game.board_size-1).each do |row|
      (0..game.board_size-1).each do |col|
        return false if !game.revealed?([row, col]) && !@previous_guesses.include?([row, col])
      end
    end
    true
  end

  def revealed_cards(game)
    revealed = []
    (0..game.board_size-1).each do |row|
      (0..game.board_size-1).each do |col|
        revealed << [row, col] if game.revealed?([row, col])
      end
    end
    revealed
  end

  def handle_new_information(info)
    #p @previous_guesses
    #puts "value: #{value}"
    #puts "last previous guess: #{@previous_guesses[-1]}"
    letter = info[:letter]
    if not @information[letter]
      @information[letter] = [@previous_guesses[-1]]
    elsif @information[letter].length < 2 && !info[:match]
      @information[letter] << @previous_guesses[-1]
    end
    @end_of_turn = !@end_of_turn
  end

end
