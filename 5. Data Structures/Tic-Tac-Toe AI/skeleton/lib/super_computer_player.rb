require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
      node = TicTacToeNode.new(game.board, mark)

      # if any of the children is a winning_node?
      found_win_node = node.children.find { |child| child.winning_node?(mark) }
      return found_win_node.prev_move_pos if found_win_node != nil

      # otherwise... 
      found_any_win_node = node.children.find { |child| !child.losing_node?(mark) }
      return found_any_win_node.prev_move_pos if found_any_win_node != nil

      raise "Well done, Human. Looks like I am going to lose..."
  end 
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
