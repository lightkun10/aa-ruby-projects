require_relative 'tile'

class Board

    def self.default_empty_grid
        Array.new(9) do
            Array.new(9) { Tile.new(0) }
        end
    end

    def self.from_file(filename)
        ### FACTORY METHOD
        rows = File.readlines(filename).map(&:chomp)

        tiles = rows.map do |row|
            numbers = row.split("").map { |char| Integer(char) }
            numbers.map { |num| Tile.new(num) }
        end

        self.new(tiles)
    end

    def initialize(grid = Board.default_empty_grid)
        @grid = grid
    end
    
    def [](pos)
        row, col = pos
        grid[row][col]
    end

    def []=(pos, value)
        row, col = pos
        grid[row][col] = value
    end

    def columns
        rows.transpose
    end

    def rows
        grid
    end

    def size
        grid.size
    end

    def render
        puts "  #{(0..8).to_a.join(" ")}"
        grid.each_with_index do |row, i|
            puts "#{i} #{row.join(" ")}"
        end
    end
    
    def play
        
    end

    def solved?
        rows.all? { |row| set_solved?(row) } &&
        columns.all? { |col| set_solved?(col) } &&
        squares.all? { |square| set_solved?(square) }
    end

    def set_solved?(tiles)
        numbers = tiles.map { |tile| tile.value }
        numbers.sort == (1..9).to_a
    end

    def square(index)
        tiles = []

        x = (index / 3) * 3
        y = (index % 3) * 3

        (x...x + 3).each do |x_axis|
            (y...y + 3).each do |y_axis|
                tiles << self[[x_axis, y_axis]]
            end
        end

        tiles
    end

    def squares
        (0...9).to_a.map { |i| square(i) } # start from 0, ends with 8
    end


    # def bongkar_pasang
    #     rows.each do |row|
    #         row.map { |tile| p tile }
    #     end
    # end

    private

    attr_reader :grid
end

# b = Board.from_file("puzzles/sudoku1.txt")
# p b.columns
# b.render
# b.solved?
# b.bongkar_pasang

=begin

rows = [
    [1,2,3],
    [4,5,6],
    [7,8,9]
]

rows.transpose

rows = [
    [1,4,7],
    [2,5,8],
    [3,6,9]
]
    
=end 
