require_relative '5. min_max_stack'

class MinMaxStackQueue
    def initialize
        @in_stack = MinMaxStack.new
        @out_stack = MinMaxStack.new
    end

    def size
        @in_stack.size + @out_stack.size
    end

    def empty?
        @in_stack.empty? && @out_stack.empty?
    end

    def enqueue(value)
        # O(1)
        @in_stack.push(value)
    end

    def dequeue
        in_out_factory if @out_stack.empty?

        @out_stack.pop
    end

    def max
        # At most two operations; O(1)
        maxes = []
        maxes.push(@in_stack.max) unless @in_stack.empty?
        maxes.push(@out_stack.max) unless @out_stack.empty?

        maxes.max
    end

    def min
        mins = []
        mins.push(@in_stack.min) unless @in_stack.empty?
        mins.push(@out_stack.min) unless @out_stack.empty?

        mins.min
    end

    private
    def in_out_factory
        @out_stack.push(@in_stack.pop) until @in_stack.empty?
    end
end