def windowed_max_range(array, window_size)
    current_max_range = nil
    num_windows = array.length - window_size + 1

    num_windows.times do |i|
        # slicing an array is rather costly (again, O(n)).
        # Remember, a new array is created when slicing an existing array.
        window = array.slice(i, window_size)
        current_range = window.max - window.min
        # It turns out that it is quite costly to calculate 
        # the min and max elements of each window (each method is an O(n) operation). 
        # If we use the min AND max methods built into Ruby, 
        # this costs us 2 * window_size iterations for each window 
        # (overall time complexity: O(n^2)).

        current_max_range = current_range if !current_max_range || current_max_range < current_range
    end

    current_max_range
end

windowed_max_range([1, 2, 3, 5], 3)
# p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8