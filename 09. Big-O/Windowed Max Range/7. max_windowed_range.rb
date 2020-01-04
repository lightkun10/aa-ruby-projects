require_relative '6. min_max_stack_queue.rb'

def max_windowed_range(array, window_size)
    best_range = nil
    queue = MinMaxStackQueue.new

    array.each do |ele|
        queue.enqueue(ele)
        queue.dequeue if queue.size > window_size

        if queue.size == window_size
            current_range = queue.max - queue.min
            
            if !best_range || current_range > best_range
                best_range = current_range
            end
        end
    end

    best_range
end

# if $PROGRAM_NAME == __FILE__
#     p max_windowed_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
#     p max_windowed_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
#     p max_windowed_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
#     p max_windowed_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
# end