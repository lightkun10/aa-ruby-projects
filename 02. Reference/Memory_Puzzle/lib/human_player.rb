class HumanPlayer
    attr_accessor :previous_player

    def initialize(_size)
        @previous_player = nil
    end

    def get_input
        prompt        
        input = gets.chomp
        input.split(",").map { |char| Integer(char) }
    end

    def prompt
        puts "\nPlease enter the position of the card you'd like to flip (e.g., '2,3')"
        print "> "
    end

    def receive_revealed_card(position, value)
        #duck typing
    end

    def define_match(_pos1, _pos2)
        puts "It's a match!"
    end
    
end