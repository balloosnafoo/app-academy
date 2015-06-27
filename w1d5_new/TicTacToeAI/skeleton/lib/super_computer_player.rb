require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    root = TicTacToeNode.new(game.board, mark)
    root_children = root.children
    root_children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end
    root_children.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end
    raise "we are awful programmers."
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = SuperComputerPlayer.new
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
