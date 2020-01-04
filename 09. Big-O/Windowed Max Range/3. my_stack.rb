class MyStack
    def initialize
        @store = []
    end

    def push(value)
        # adds an element to the top of the stack
        @store.push(value)
    end

    def pop
        # removes an element from the top of 
        # the stack and returns it
        @store.pop
    end

    def peek
        @store.last
    end

    def size
        @store.size
    end

    def empty?
        @store.empty?
    end
end