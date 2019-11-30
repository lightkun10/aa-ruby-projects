require 'colorize'

class Tile
    attr_reader :value

    def initialize(value)
        @value = value
        @given = if value == 0
            false
        else
            true
        end
    end

    def color
        given? ? :blue : :red
    end

    def to_s
        if value == 0
            " "
        else
            value.to_s.colorize(color)
        end
    end

    def given?
        @given
    end

    def value=(new_value)
        if given?
            puts "You can't change value that's already given!"
        else
            @value = new_value
        end
    end
end