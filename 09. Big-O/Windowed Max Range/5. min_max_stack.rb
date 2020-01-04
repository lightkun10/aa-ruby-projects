require_relative '3. my_stack'

class MinMaxStack
    def initialize
        @store = MyStack.new
    end

    def peek
        @store.peek[:value] unless empty?
    end

    def size
        @store.size
    end

    def empty?
        @store.empty?
    end

    def max
        @store.peek[:stored_max] unless empty?
    end

    def min
        @store.peek[:stored_min] unless empty?
    end

    def pop
        @store.pop[:value] unless empty?
    end

    def push(value)
        @store.push({
            stored_max: new_max(value),
            stored_min: new_min(value),
            value: value
            # each stored/previous max&min will be compared with
            # next value that waiting to be stored
            # the default will be the first one stored
        })
    end

    private 
    def new_max(value)
        if empty?
            value
        else
            [max, value].max
            # compare the item waiting stored with the existing max value
            # I can use MinMaxStack.max method here, utilizing peeking feature
        end
    end

    def new_min(value)
        if empty?
            value
        else
            [min, value].min
            # compare the item waiting stored with the existing min value
            # I can use MinMaxStack.min method here, utilizing peeking feature
        end
    end
end