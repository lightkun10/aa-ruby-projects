class MyQueue
    def initialize
        @store = []
    end

    def enqueue(value)
        # adds an element to the back of the queue
        @store.push(value)
    end

    def dequeue
        # removes an element from the front 
        # of the queue and returns it
        @store.shift
    end

    def size
        @store.size
    end

    def empty?
        @store.empty?
    end

    def peek
        @store.last
    end
end