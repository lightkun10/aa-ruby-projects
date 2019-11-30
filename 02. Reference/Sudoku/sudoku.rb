require_relative 'tile'
require_relative 'board'

class SudokuGame
    attr_reader :board

    def self.from_file(filename)
        ### FACTORY METHOD
        board = Board.from_file(filename)
        self.new(board)
    end

    def initialize(board)
        @board = board
    end

    def get_position
        pos = nil

        until pos && valid_position?(pos)
            puts "Please enter a position on the board (e.g., '3,4')"
            print "> "
            pos = gets.chomp.split(",").map { |char| Integer(char) }
        end

        pos
    end

    def get_value
        val = 0

        until val > 0 && val <= 9 && val.is_a?(Integer)
            puts "Please enter a value between 1 and 9"
            print "> "
            val = Integer(gets.chomp)
        end

        val
    end

    def board_player_interaction  
        # "Please enter a position on the board (e.g., '3,4')"
        # position
        # "Please enter a value between 1 and 9"
        # value

        # board[position] = value
        board.render
        pos = get_position
        value = get_value
        
        board[pos] = value
    end

    def valid_position?(pos)
=begin
        Valid position is when:            
        - input is an Array
        - input length is 2
        - input is between 0 and size of the board minus one(indexing start from 0)
=end
        pos.is_a?(Array) &&
        pos.length == 2 &&
        pos.all? { |x| x.between?(0, board.size - 1) }
    end

    def play
        board_player_interaction until solved?
        board.render
        puts "You win!"
    end

    def solved?
        board.solved?
    end


end

game1 = SudokuGame.from_file("puzzles/sudoku1.txt")
game1.play

# def factorial(n)
#     return 1 if n == 1
#     puts n
#     n * factorial(n-1)
# end