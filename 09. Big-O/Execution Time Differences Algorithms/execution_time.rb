#======= my_min =======
list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]

#===== Phase I-a
### Time complexity = O(n^2), Quadratic time
### Space complexity = O(1), Constant space
def my_min_1a(list)
    list.each_with_index do |int1, i1|
        min_count = false

        list.each_with_index do |int2, i2|
            next if i1 == i2
            min_count = true if int1 > int2
        end

        return int1 if min_count == false
    end
end

#===== Phase I-b
### Time complexity = O(n^2), Quadratic time
### Space complexity = O(1), Quadratic space
def my_min_1b(list)
    smallest = list[0]

    list.each do |num|
        smallest = num if smallest > num
    end

    smallest
end

#===== Phase II
### Time complexity = O(n), Linear time
### Space complexity = O(1), Constant space
def my_min_2(list)
    minimum = list[0]

    list.each_with_index do |int, i|
        minimum = int if minimum > int
    end

    minimum
end

#==========================================================================================================

############# Largest Contiguous Sub-sum #############

list1 = [5, 3, -7]
list2 = [2, 3, -6, 7, -6, 7]

#===== Phase I
### Time complexity = O(n^3), Cubic time
### Space complexity = O(n^3), Cubic space
def largest_contiguous_subsum1(list)
    sub_arr = []

    list.each_with_index do |num, i1|
        (i1...list.length).each do |i2|
            sub_arr.push(list[i1..i2])
        end
    end

    sub_arr.map! { |sub| sub.inject(:+) }.max
end

#===== Phase II
### Time complexity = O(n)
### Space complexity = O(1)
def largest_contiguous_subsum2(list)
    largest = list[0]
    current = list[0]

    (1...list.length).each do |i|
        if current < 0 # << Reset to 0 if it dips into negative num
            current = 0
        end

        current += list[i]
        
        if largest < current
            largest = current
        end
    end

    largest
end