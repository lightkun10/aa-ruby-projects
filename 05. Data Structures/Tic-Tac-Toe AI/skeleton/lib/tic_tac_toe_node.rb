require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
      @board, @next_mover_mark, @prev_move_pos = 
          board, next_mover_mark, prev_move_pos 
  end

  def losing_node?(evaluator)
      if board.over?
          return board.won? && board.winner != evaluator
      end
      
      if self.next_mover_mark == evaluator
          self.children.all? { |node| node.losing_node?(evaluator) }
      else
          self.children.any? { |node| node.losing_node?(evaluator) }
      end
      
  end

  def winning_node?(evaluator)
      if board.over?
          return board.winner == evaluator
      end

      if self.next_mover_mark == evaluator
          self.children.any? { |node| node.winning_node?(evaluator) }
      else
          self.children.all? { |node| node.winning_node?(evaluator) }
      end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
      children = []

      # All potential game states
      # One move after the current node
      (0...3).each do |row_idx|
          (0...3).each do |col_idx|
              pos = [row_idx, col_idx]
              next unless board.empty?(pos)

              new_board = board.dup
              new_board[pos] = self.next_mover_mark

              if self.next_mover_mark == :x
                  next_mover_mark = :o
              else
                  next_mover_mark = :x
              end

              children.push(TicTacToeNode.new(new_board, next_mover_mark, pos))
          end
      end

      children
  end
end
