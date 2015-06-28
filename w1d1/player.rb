class HumanPlayer

  def get_card(game)
    print "Pick a card: "
    gets.chomp.split(", ").map(&:to_i)
  end

  def handle_new_information(info)
  end

end

class ComputerPlayer
  attr_reader :board, :information

  def initialize
    @information = {}
    @previous_guesses = []
    @end_of_turn = false
  end

  def get_card(game)
    sleep(1)
    guess = matching_guess(game)
    return guess ? guess : random_guess(game)
  end

  def random_guess(game)
    limit = game.board_size
    pos = [ rand(limit), rand(limit) ]
    pos = [ rand(limit), rand(limit) ] until new_guess?(pos)
    @previous_guesses << pos
    pos
  end

  def new_guess?(pos)
    !@previous_guesses.include?(pos)
  end

  def matching_guess(game)
    guess, to_delete = nil, nil
    information.each do |key, value|
      if value.length == 2
        guess = game.revealed?(value[0]) ? value[1] : value[0]
        to_delete = key
      end
    end
    information.delete(to_delete) if @end_of_turn && guess
    return guess
  end

  def handle_new_information(info)
    letter = info[:letter]
    if !info[:match]
      if not @information[letter]
        @information[letter] = [@previous_guesses[-1]]
      elsif @information[letter].length < 2 
        @information[letter] << @previous_guesses[-1]
      end
    end
    @end_of_turn = !@end_of_turn
  end

end
