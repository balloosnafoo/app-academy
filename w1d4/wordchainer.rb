require 'set'

class WordChainer
  attr_reader :dict_words
  attr_accessor :current_words, :all_seen_words
  def initialize(dictionary_file_name)
    @dict_words = Set.new
    File.foreach(dictionary_file_name) { |line| @dict_words << line.chomp }
    @current_words = []
    @all_seen_words = []
  end

  def adjacent_words(word)
    same_length_words = dict_words.select {|d_w| d_w.length == word.length}
    same_length_words.select do |word2|
      differences = 0
      word.each_char.with_index do |_, id|
        differences += 1 if word2[id] != word[id]
      end
      differences == 1
    end
  end

  def run(src, target)
    current_words << src
    while current_words.length > 0
      new_current_words = []
      current_words.select do |cur_word|
        adjacent_words(cur_word).each do |adj_word|
          unless all_seen_words.include?(adj_word)
            new_current_words << adj_word
            all_seen_words << adj_word
          end
        end
      end
      current_words = new_current_words
      print new_current_words
    end
  end
end

wc = WordChainer.new("dictionary.txt")
p wc.adjacent_words("ruse")
