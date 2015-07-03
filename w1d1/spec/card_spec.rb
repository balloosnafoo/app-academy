require 'rspec'
require 'card'

describe Card do
  let(:card) { Card.new(5)}

  describe "#initialize" do

    it "sets the correct letter" do
      expect(card.letter == 5).to be true
    end

    it "sets revealed to false" do
      expect(card.revealed).to be false
    end
  end

  describe "#to_s" do

    context "when revealed is true" do
    
      it "returns the letter as a string" do
        card.reveal
        expect(card.to_s).to eq("5")
      end

    end

    context "when revealed is false" do

      it "returns the string ' '" do
        expect(card.to_s).to eq(" ")
      end

    end
  end

end