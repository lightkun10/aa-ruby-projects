require 'byebug'

## Warmup
# Write a recursive method, range, that takes a start and an end and returns an array of all numbers in that range, exclusive. 
#   For example, range(1, 5) should return [1, 2, 3, 4]. If end < start, you can return an empty array.
#   Write both a recursive and iterative version of sum of an array.

def range(min, max) # recursive
    # base case
    # return [] if max <= min
    return [] if max <= min

    range(min, max - 1) << max - 1
end

def iterative_range(min, max)
    arr = []
    (min...max).each { |num| arr << num }
    arr
end

# p range(1, 5) #=> [1, 2, 3, 4]
# p range(5, 1)
# p range(1, 20)

# p iterative_range(1, 5)
# p iterative_range(5, 1)
# p iterative_range(1, 20)

####################################################################################################################

## recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)

def exponent1(base, power)
    # base case
    return 1 if power < 1
    return base if power == 1

    base * exponent(base, power - 1)
end

# p exponent(90, 1)
# p exponent(2, 2)

def exponent2(base, power)
    return 1 if power < 1
    return base if power == 1

    half = exponent2(base, power / 2)

    if power % 2 == 0 # even
        half * half
    else # odd
        base * half * half
    end

    # exponent2(base, power / 2) ** 2
end

# p exponent2(2, 253)

####################################################################################################################

## Deep dup

# Using recursion and the is_a? method, write an Array#deep_dup method that will perform 
#   a "deep" duplication of the interior arrays.

class Array
    def deep_dup
        new_array = []

        self.each do |ele|
            if ele.is_a?(Array)
                new_array << ele.deep_dup
            else
                new_array << ele
            end
        end
        new_array
    end
end

####################################################################################################################

## Fibonacci

# Write a recursive and an iterative Fibonacci method. 
# The method should take in an integer n and return the first n Fibonacci numbers in an array.

# You shouldn't have to pass any arrays between methods; you should be able to do this 
# just passing a single argument for the number of Fibonacci numbers requested.

# [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55...]

def fibs(n)
    # base case
    return [] if n < 1
    return [0] if n == 1
    return [0, 1] if n == 2

    # recursive case
    prev_fibs = fibs(n - 1) # [0, 1]
    fibs(n - 1) << prev_fibs[-1] + prev_fibs[-2]
end

# p fibs(1) #=> [0]
# p fibs(2) #=> [0, 1]
# p fibs(3) #=> [0, 1, 1]
# p fibs(11)

def fibs_iteration(n)
    return [] if n < 1
    return [0] if n == 1

    fibs = [0, 1]

    while fibs.length < n
        fibs << fibs[-1] + fibs[-2]
    end

    fibs
end

# p fibs_iteration(11)

####################################################################################################################

## Binary Search

=begin

The binary search algorithm begins by comparing the target value to the value of the middle element of the sorted array. 
- If the target value is equal to the middle element's value, then the position is returned and the search is finished. 
- If the target value is less than the middle element's value, then the search continues on the lower half of the array; 
- if the target value is greater than the middle element's value, then the search continues on the upper half of the array. 
    
This process continues, eliminating half of the elements, and comparing the target value to the value of the middle element 
of the remaining elements - until the target value is either found (and its associated element position is returned), 
or until the entire array has been searched (and "not found" is returned).

Write a recursive binary search: bsearch(array, target). 
    Note that binary search only works on sorted arrays. 
    Make sure to return the location of the found object (or nil if not found!). 
    Hint: you will probably want to use subarrays.

=end


def bsearch(array, target)
    return nil if array.length == 0

    middle_idx = array.length / 2 

    case target <=> array[middle_idx]
    when -1
        # search in left
        bsearch(array.take(middle_idx), target)
    when 0 # FOUND IT!
        middle_idx
        # search in right
    when 1
        remains = bsearch(array.drop(middle_idx + 1), target)
        # remains.nil? ? nil : (middle_idx + 1) + remains
    end
end

# def bsearch_iter(array, target)
#     array.each_with_index do |ele, i|
#         return i if ele == target
#     nil
# end

# Test cases
# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

####################################################################################################################

## Merge Sort

=begin

Implement a method merge_sort that sorts an Array:

- The base cases are for arrays of length zero or one. Do not use a length-two array as a base case. 
    This is unnecessary.
- You'll want to write a merge helper method to merge the sorted halves.
- To get a visual idea of how merge sort works: 
    watch this gif: https://en.wikipedia.org/wiki/Merge_sort#/media/File:Merge-sort-example-300px.gif
    & check out this diagram: https://assets.aaonline.io/fullstack/ruby/assets/merge-sort-diagram.png

=end

class Array
    def merge_sort
        # debugger
        return self if count <= 1
        
        middle = self.count / 2

        left = self.take(middle)
        right = self.drop(middle)

        # base case
        sorted_left = left.merge_sort
        sorted_right = right.merge_sort   

        merge(sorted_left, sorted_right)
    end

    def merge(left, right)
        merged = []

        until left.empty? || right.empty?
            if left.first > right.first
                merged << right.shift
            else
                merged << left.shift
            end
        end

        merged + left + right
    end 
end

# arr = [4, 2, 3, 1]
# p arr.merge_sort

# arr2 = [38, 27, 43, 3, 9, 82, 10]
# p arr2.merge_sort

####################################################################################################################

## Array Subsets

=begin

Write a method subsets that will return all subsets of an array.
You can implement this as an Array method if you prefer.

Hint: For subsets([1, 2, 3]), there are two kinds of subsets:

    -Those that do not contain 3 (all of these are subsets of [1, 2]).
    - For every subset that does not contain 3, there is also a corresponding subset 
      that is the same, except it also does contain 3.

=end

class Array
    # def subsets
    #     debugger

    #     return [[]] if self.length == 0 # BASE CASE

    #     subs = self.take(count - 1)
    #     sets = subs.subsets
    #     sets.concat(sets.map { |set| set += [self.last] })
    # end

    def subsets
        # debugger
        return [[]] if self.length == 0

        # sets = subsets(self[0...-1])
        sets = self[0...-1].subsets
        sets.concat(sets.map { |set| set += [last] })
    end
end

# arr = []
# p arr.subsets #=> [[]]
# arr2 = [1]
# p arr2.subsets # => [[], [1]]
# arr3 = [1, 2] # => [[], [1], [2], [1, 2]]
# p arr3.subsets

# ex = [2,4,9]
# p ex.subsets

####################################################################################################################

## Permutations

=begin

Write a recursive method permutations(array) that calculates all the permutations of the given array. 
For an array of length n there are n! different permutations. 
So for an array with three elements we will have 3 * 2 * 1 = 6 different permutations.

=end

def permutations(array)
    # debugger
    
    # base case
    return [array] if array.length <= 1

    # pop of the last element
    first = array.shift
    # make the recursive call
    perms = permutations(array)
    # we will need an array to store all our different permutations
    total_perms = []

    # Now we iterate over the result of our recursive call say [[1, 2], [2, 1]]
    # and for each permutation add first into every index. This new subarray
    # gets added to total_permutations.
    perms.each do |perm|
        (0..perm.length).each do |i|
            total_perms << perm[0...i] + [first] + perm[i..-1]
        end
    end

    total_perms    
end

# p permutations([1])

# p permutations([1, 2]) #=> [[1, 2], [2, 1]]

# p permutations([1, 2, 3]) 
# # => [[1, 2, 3], [1, 3, 2],
# #     [2, 1, 3], [2, 3, 1],
# #     [3, 1, 2], [3, 2, 1]]

####################################################################################################################

def make_change(amount, coins = [25, 10, 5, 1])
    # relies on coins being in descending order.
    
    change = []

    first_coin = coins[0]
    count = amount / first_coin
    count.times { change << first_coin }
    amount = amount - count * first_coin

    # to use the other coin
    if amount > 0
        change = change + make_change(amount, coins.drop(1))
    end

    change
end

p make_change(99)