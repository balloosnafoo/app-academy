
class WordChainer

  def initialize(dictionary)
    @dictionary = dictionary
  end

  def self.dictionary_from_file(filename)
    File.readlines(filename).map(&:chomp)
  end

  # Implement find_target method using WordNode#bfs

end
