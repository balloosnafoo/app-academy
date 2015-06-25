class Card
  attr_reader :revealed, :letter

  def initialize(letter)
    @letter = letter
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def hide
    @revealed = false
  end

  def to_s
    @revealed ? @letter : " "
  end

  def ==(other_card)
    @letter == other_card.letter
  end

end
