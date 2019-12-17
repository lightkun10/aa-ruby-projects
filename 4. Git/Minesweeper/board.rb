require_relative 'tile'

class Board
    attr_reader :grid_size, :num_of_bombs

    def initialize(grid_size, num_of_bombs)
        @grid_size, @num_of_bombs = grid_size, num_of_bombs
        
        load_board
    end

    ################################
    #         Game Logic           #
    ################################

    def [](pos) # [2, 1]
        row, col = pos
        @grid[row][col] # @grid[2][1] == @grid[2, 1]
    end


    ################################
    #           Game UI            #
    ################################

    def load_board
        @grid = Array.new(@grid_size) do |row|
            Array.new(@grid_size) do |col|
                Tile.new(self, [row, col])
            end
        end
        plant_bombs
    end

    def plant_bombs
            total_bombs = 0 # << counter
            while total_bombs < @num_of_bombs
                random_pos = Array.new(2) { rand(@grid_size) }
                next if self[random_pos].bombed?
                self[random_pos].plant_bomb
                # p "#{total_bombs} until all bombs's planted..."
                total_bombs += 1
                print "\nAll bombs has planted\n\n" if total_bombs == 5
            end
        nil
    end
end


# if $PROGRAM_NAME == __FILE__
#     Board.new(9, 5)
#     # puts "\nThis will only be printed when directly launched."
# end