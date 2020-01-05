require 'byebug'
# arr = [0, 1, 5, 7]

### O(n), Linear Time
### O(1), Constant space
def bad_two_sum_a?(arr, target_sum)
    arr.length.times do |i|
        break if i == arr.length - 1
        return true if arr[i] + arr[i + 1] == target_sum
    end

    false
end

### O(n^2), Quadratic time
### O(1), Constant space
def bad_two_sum_b?(arr, target_sum)
    arr.length.times do |i|
        (arr.length - i - 1).times do |j|
            if arr[i] + arr[j + i + 1] == target_sum
                return true
            end
        end
    end
    
    false
end

#===========================================================================================================================================

arr = [9, 6, 5, 1]

### #O(nlogn), Linearithmic time
### O(n),  Linear space
def okay_two_sum?(arr, target_sum)
    ary = arr.sort

    i = 0
    j = ary.length - 1

    while j > i
        case (ary[i] + ary[j]) <=> target_sum
        when 0
            return true
        when 1
            j -= 1
        when -1
            i += 1
        end
    end

    false
end


#===========================================================================================================================================

=begin
 ==== Hash Map ====

=end

#O(n), linear time
#O(n), linear space
def two_sum?(arr, target_sum)
    complements = Hash.new(0)

    arr.each_with_index do |ele, i|
        return true if complements[target_sum - ele]
        complements[ele] = true
    end

    false
end
