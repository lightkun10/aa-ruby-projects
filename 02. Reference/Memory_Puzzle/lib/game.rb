require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class MemoryGame
    attr_reader :player
    attr_accessor :previous_guess_pos
    
    def initialize(player, size = 4)
        # remember, nil == "no value"
        @size = size
        @player = player
        @board = Board.new(size)
        @previous_guess_pos = nil
    end

    def compare_guess(new_guess_pos) # [2,1]
        # p previous_guess_pos.to_s # << FOR DEBUGGING
        if self.previous_guess_pos != nil
            # if board[self.previous_guess_pos] == board[new_guess_pos]
            if match?(previous_guess_pos, new_guess_pos)
                player.define_match(previous_guess_pos, new_guess_pos)
                board.reveal(new_guess_pos)
            else
                puts "Try Again..."
                [self.previous_guess_pos, new_guess_pos].each { |pos| board.hide(pos) }
            end
            self.previous_guess_pos = nil
        else
            self.previous_guess_pos = new_guess_pos
        end
    end


    def get_player_input
        position = nil

        until position != nil && valid_pos?(position)
            position = player.get_input
        end

        position
    end
 
    ## (Memory/matching logic) 
    def make_guess(position) #[2, 1]
        revealed_value = board.reveal(position)
        player.receive_revealed_card(position, revealed_value)
        board.render
        compare_guess(position)

        sleep(1)
        board.render
    end

    def match?(pos1, pos2)
        board[pos1] == board[pos2]
    end

    ## (Main game loop)
    def play 
        until board.won?
            board.render
            # get_input = HumanPlayer.new(@size).get_input
            position = get_player_input
            make_guess(position)
            # break # << FOR DEBUGGING PURPOSE
        end

        puts "You win!"
    end

    # anticipate if input is valid or not
    def valid_pos?(position)
        position.is_a?(Array) && 
        position.count == 2 && 
        position.all? { |pos| pos.between?(0, board.size - 1) }
    end


    private

    # attr_accessor :previous_guess_pos
    attr_reader :board
end

g1 = MemoryGame.new(ComputerPlayer.new(4))
g1.play