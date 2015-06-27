
class WordNode

  attr_accessor :parent

  def initialize(value, dictionary)
    @value = value
    @dictionary = dictionary
    @parent = nil
  end

  def children
    current_word = @value
    new_dict = @dictionary.select { |word| word.length == current_word.length }
    new_dict.select! do |word|
      remaining_letters = word.dup
      current_word.each_char { |char| remaining_letters.sub!(char, '') }
      remaining_letters.length == 1
    end
    new_dict.map! { |word| WordNode.new(word, @dictionary) }
    new_dict.each { |word| word.parent = self }
    new_dict
  end

  # Implement breadth first search to find target word from start word in
  # fewest steps.

end
