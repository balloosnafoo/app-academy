require_relative "players"

class Game
  attr_reader :fragment

  def initialize(*args)
    @fragment = ""
    @players = args
    @dictionary = import_dictionary
    @current_player = @players[0]
    @loser = nil
  end

  def import_dictionary
    d = Hash.new(false)
    File.readlines("./dictionary.txt").map(&:chomp).each { |w| d[w] = true }
    d
  end

  def run
    print_instructions
    play_round until @players.any? {|player| player.print_letters == "GHOST"}
    @players.delete_if {|player| player.letters == 5}
    p @players
    puts "Congratulations! #{@players.first} won the game!"
  end

  def play_round
    display_scores
    until @loser
      play_turn
      @previous_player = @current_player
      switch
    end
    puts "Sorry #{@loser}! You lose this round!"
    @loser.add_letter
    @fragment, @loser = "", nil
  end

  def print_instructions
    puts "Welcome to Ghost! Blah Blah Blah"
    puts "If you want to call BS on your opponent, type 'bs'."
  end

  def play_turn
    display_fragment if @fragment
    guess = @current_player.make_guess(self) until valid?(guess)
    handle_guess(guess)
  end

  def switch
    @current_player = @players[(@players.index(@current_player) + 1) % @players.size]
  end

  def other_player
    @players[(@players.index(@current_player) + 1) % 2]
  end

  def valid?(guess)
    ('a'..'z').include?(guess) || guess == 'bs'
  end

  def handle_guess(guess)
    if guess == 'bs'
      defense = @previous_player.defend_guess(@fragment)
      valid_defense = @dictionary[defense] && defense[0...-1] == @fragment
      @loser = valid_defense ? @current_player : @previous_player
    else
      @fragment += guess
    end
  end

  def display_fragment
    puts "The current fragment is #{@fragment}. #{@current_player} is up."
  end

  def display_scores
    @players.each {|player| puts "#{player} has #{player.print_letters}"}
  end

  def num_players
    @players.length
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new(HumanPlayer.new("Matt"), AiPlayer.new)
  g.run
end
