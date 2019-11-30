class ComputerPlayer
    attr_accessor :previous_guess_pos, :known_cards, :board_size #:matched_cards

    def initialize(size)
        @board_size = size
        @known_cards = Hash.new # {}
        @matched_cards = Hash.new # {}
        @previous_guess_pos = nil
    end
    
    ## accept the revealed card information from the game
    def receive_revealed_card(position, value)
        @known_cards[position] = value
    end

    ## #receive_match should take in two positions which are a successful match.
    # store in matched_cards
    def receive_match(position1, position2)
        @matched_cards[position1] = true
        @matched_cards[position2] = true
    end

    def get_input
        if first_guess
            second_guess
        else
            first_guess
        end
    end

    def unmatched_pos
        ## only scan the position

        # pos = @known_cards.find do |pos, val|
        (pos, _) = @known_cards.find do |pos, val|
            @known_cards.any? do |pos2, val2|
                pos != pos2 && val == val2 &&
                !(@matched_cards[pos] || @matched_cards)
            end
        end

        pos
    end

    def match_previous
        (pos, _) = @known_cards.find do |pos, val|
            # position no the same
            # value is the same with previous guess
            # not a match previously
            pos != previous_guess_pos && val == @known_cards[previous_guess_pos] &&
            !matched_cards[pos]
        end

        pos
    end

    ## Computer's strategy/logic
    def first_guess
        unmatched_pos || random_guess
    end

    def second_guess
        match_previous || random_guess
    end

    def random_guess
        guess = nil
        
        until guess && !@known_cards[guess]
            guess = [rand(board_size), rand(board_size)]
        end

        guess
    end

end

cpu = ComputerPlayer.new(4)
cpu.receive_revealed_card([0,3], "K")
cpu.receive_revealed_card([2,1], "J")
p cpu.known_cards

p cpu.first_guess
p cpu.second_guess