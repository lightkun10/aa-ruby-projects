class Card
    VALUES = ("A".."Z").to_a

    def self.shuffled_pairs(number_of_pairs)
        values = VALUES
        while number_of_pairs > values.length
            values = values + values
        end
        # board(4) =>  size 4*2 = 8
        values_to_take = values.shuffle.take(number_of_pairs) * 2 # times 2 is for row and col
        values_to_take.shuffle!
        values_to_take.map { |value| self.new(value) }
    end

    attr_reader :value

    def initialize(value, face_up = false)
        @value = value
        @face_up = face_up
    end
    
    def hide
        @face_up = false
    end

    def reveal
        @face_up = true
    end

    def revealed?
        @face_up
    end

    # display information about the card
    # nothing when face-down, or its value when face-up
    def to_s
        if revealed?
            value.to_s
        else
            " "
        end
    end

    def ==(other_card_object)
        other_card_object.is_a?(self.class) && other_card_object.value == value
    end

    # puts "Self is: #{self}"
    # puts "Self class is: #{self.class}"
end

# card1 = Card.new("K") 
# card2 = Card.new("Q")
# card3 = Card.new("J")

# Card.shuffled_pairs(4)