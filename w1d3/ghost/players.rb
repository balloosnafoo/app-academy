class Player
  attr_reader :name, :letters

  def initialize(name)
    @name = name
    @letters = 0
  end

  def to_s
    @name
  end

  def add_letter
    @letters += 1
  end

  def print_letters
    "GHOST"[0...@letters]
  end

end

class HumanPlayer < Player

  def make_guess(game)
    puts "Please enter a letter:"
    gets.chomp
  end

  def defend_guess(fragment)
    puts "#{@name}, you have been challenged! Enter a word that contains the fragment..."
    puts "(or suffer a humiliating loss)"
    gets.chomp
  end


end

class AiPlayer < Player

  def initialize
    @letters = 0
    @name = "RoboGuesser" + random_number
    @dictionary = import_dictionary
    @fragment = ""
  end

  def random_number
    number = "%04d" % rand(1000)
  end

  def make_guess(game)
    @fragment = game.fragment
    letter = winning_move(game.num_players) || first_available_move
    puts letter == "bs" ? "I declare BS!!" : "I append the letter #{letter}"
    return letter
  end

  # def winning_move(total_players)
  #   cw = candidate_words(total_players).select { |word| can_come_back?(word, total_players) && has_longer_words?(word) }
  #   return cw.empty? ? nil : cw.first[@fragment.length]
  # end

  def winning_move(total_players)
    cw = candidate_words(total_players).select { |word| !can_come_back?(word, total_players) && has_longer_words?(word) }
    if cw.empty?
      return nil
    else
      puts "I just played a winning move"
      cw.first[@fragment.length]
    end
  end

  def first_available_move
    words.each do |word|
      return word[@fragment.length] if word[0...@fragment.length] == @fragment && word.length > @fragment.length + 1
    end
    'bs'
  end

  def defend_guess(fragment)
    @fragment = fragment
    word = words.find do |word|
      word if word[0...@fragment.length] == @fragment && word.length > @fragment.length + 1
    end
    puts word ? "You fool! There is still the word #{word}!" : "You got me..."
    word
  end

  private

  def candidate_words(total_players)
    words.select do |word|
      word[0...@fragment.length] == @fragment &&
        (word.length - @fragment.length) < total_players
    end
  end

  def can_come_back?(word, total_players)
    !words.any? { |word2| word2[0...word.length] && (word.length - @fragment.length) >= total_players}
  end

  def has_longer_words?(word)
    words.any? { |other_word| other_word[0..@fragment.length] == word[0..@fragment.length] &&
                  other_word.length > @fragment.length + 1 }
  end

  def import_dictionary
    d = Hash.new(false)
    File.readlines("./dictionary.txt").map(&:chomp).each { |w| d[w] = true }
    d
  end

  def words
    @dictionary.keys
  end

end
