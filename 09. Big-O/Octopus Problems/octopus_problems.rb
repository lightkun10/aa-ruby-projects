#=============== Big O-ctopus and Biggest Fish ===============

# A Very Hungry Octopus wants to eat the longest fish in an array of fish.
fishes = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

##### Sluggish Octopus #####
# Find the longest fish in O(n^2) time. 
# Do this by comparing all fish lengths to all other fish lengths

## O(n^2) time, "Quadratic Time".
def sluggish_octopus(fishes) 
    fishes.each_with_index do |fish1, i1|
        max_length = true
        fishes.each_with_index do |fish2, i2|
            next if i1 == i2
            # puts "#{fish1} --- #{fish2}"
            max_length = false if fish1.length < fish2.length
        end

        return fish1 if max_length == true
    end
end

##### Dominant Octopus #####
# Find the longest fish in O(n log n) time.
# Hint: You saw a sorting algorithm that runs in O(n log n) in the Sorting Complexity Demo. 
# Remember that Big O is classified by the dominant term.

# O(n log n) time... I can use Merge Sort.
class Array
    def merge_sort
        return self if count <= 2

        mid = count / 2
        sorted_left = self.take(mid).merge_sort
        sorted_right = self.drop(mid).merge_sort

        Array.merge(sorted_left, sorted_right)
    end

    def self.merge(left, right)
        merged = []
        until left.empty? || right.empty?
            if left.first.length < right.first.length
                merged.push(left.shift)
            else
                merged.push(right.shift)
            end
        end

        merged += (left + right)
    end
end

## O(n log n) time, "Log Linear/Super Linear Time"
def dominant_octopus(fishes)
    fishes.merge_sort[-1]
end

##### Clever Octopus #####
# Find the longest fish in O(n) time.
# The octopus can hold on to the longest fish that you have found so far while 
# stepping through the array only once.

## O(n) time, "Linear Time".
def clever_octopus(fishes)
    current_biggest_fish = fishes[0]

    fishes.each_with_index do |fish, i|
        if fish.length > current_biggest_fish.length
            current_biggest_fish = fish
        end
    end

    current_biggest_fish
end

#===================================================================================================================

#=============== Dancing Octopus ===============

# Full of fish, the Octopus attempts Dance Dance Revolution. 
# The game has tiles in the following directions:

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

# To play the game, the octopus must step on a tile with her corresponding tentacle. 
# We can assume that the octopus's eight tentacles are numbered and 
# correspond to the tile direction indices.

##### Slow Dance #####
# Given a tile direction, iterate through a tiles array to return the tentacle number (tile index) 
# the octopus must move. This should take O(n) time.

# O(n) time, "Linear Time".
def slow_dance(direction, tiles_array)
    tiles_array.each_with_index do |string_tile, i|
        return i if direction == string_tile
    end
end

##### Constant Dance! #####
# Now that the octopus is warmed up, let's help her dance faster. 
# Use a different data structure and write a new function so that you can access the tentacle number 
# in O(1) time.

# O(1) time... I can use Hash.
# On average case, time complexity for Hash(table) is O(1).

tiles_hash = {
    "up"=>0, "right-up"=>1, "right"=>2, "right-down"=>3,
    "down"=>4, "left-down"=>5, "left"=>6, "left-up"=>7
}

# O(1) time, "Constant Time".
def fast_dance(direction, tiles_hash)
    raise "You can't move like that, oct :(" if tiles_hash[direction] == nil
    tiles_hash[direction]
end