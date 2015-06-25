require_relative "board"
require_relative "player"

class Game
  attr_accessor :board, :player1, :player2, :turn

  def initialize
    @board = Board.new
    @player1 = Player.new(:red)
    @player2 = Player.new(:black)
    @turn = 0
  end

  def play
    players = [@player1, @player2]
    until over? do
      move = players[turn % 2].get_move
      @board.drop_piece(move, players[turn % 2].symbol)
      @turn += 1
      @board.display
    end
    puts "Player #{1 + @turn % 2} wins!"
  end


  def over?
    @board.win?
  end


end

g = Game.new
g.play
