require_relative 'card'

class Board
    attr_reader :size

    def initialize(size = 4)
        @grid = Array.new(size) { Array.new(size) }
        @size = size
        populate
    end

    def [](position)
        row, column = position
        grid[row][column]
    end

    def []=(position, value)
        row, column = position
        grid[row][column] = value
    end

    def hide(position)
        self[position].hide
    end

    # populate should fill the board with a set of shuffled Card pairs
    def populate
        number_of_pairs = (size**2) / 2
        # dibagi dua krn masing2 kartu punya kembaran/pair
        cards = Card.shuffled_pairs(number_of_pairs)
        # populate the entire board with shuffled deck
        grid.each_index do |i|
            grid[i].each_index do |j|
                self[[i, j]] = cards.pop
            end
        end
        # p cards
        # p cards.count
    end

    def revealed?(position)
        self[position].revealed?
    end

    def reveal(position)
        if revealed?(position)
            puts "Card already revealed..."
        else
            self[position].reveal
        end

        self[position].value
    end

    def won?
        @grid.all? do |row|
            row.all? { |card| card.revealed? }
        end
    end

    #render should print out a representation of the Board's current state
    def render
        system("clear")
        puts "  #{(0...size).to_a.join(" ")}"
        @grid.each_with_index do |row, i|
            puts "#{i} #{row.join(" ")}"
        end
    end


    private

    attr_reader :grid
end

board = Board.new
p board.reveal([2,1])