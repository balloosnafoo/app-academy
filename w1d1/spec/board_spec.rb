require 'rspec'
require 'board'
  
describe Board do 
  let(:board) { Board.new(6) }
	
  describe "#initialize" do

    it "should create a square board of the specified size" do
      expect(board.grid.length).to eq(6)
      expect(board.grid[0].length).to eq(6)
    end

    it "should create a blank board" do
      expect(board.grid.flatten.all? { |tile| tile.nil? }).to be true
    end

  end

  describe "#populate" do

    it "should not leave any nil squares" do
      board.populate
      expect(board.grid.flatten.any? { |tile| tile.nil? }).to be false
    end

    it "should have two of each number" do
      board.populate
      expect(
        (1..16).all? { |i| board.grid.flatten.count { |c| c.letter == i } == 2 }
      ).to be true
    end

  end

  describe "#match?" do
    let(:card1) { Card.new(1) }
    let(:card2) { Card.new(1) }
    let(:card3) { Card.new(2) }

    it "should return true when cards have same letter" do
      expect(card1 == card2).to be true
    end

    it "should return false when cards have different letter" do
      expect(card1 == card3).to be false
    end
  end

  describe "#won?" do

    it "should correctly diagnose a won game" do
      board.populate
      board.grid.flatten.each { |card| card.reveal }
      expect(board.won?).to be true
    end

    it "should correctly diagnose an unfinished game" do
      board.populate
      expect(board.won?).to be false
    end
  end
	
end