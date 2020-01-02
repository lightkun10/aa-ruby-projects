# For example:
# anagram?("gizmo", "sally")    #=> false
# anagram?("elvis", "lives")    #=> true

#===== Phase I =====

### O(n!) Combinatorial/Factorial time
### O(n!) Combinatorial/Factorial space
### WARNING: These version can be dangerous. Activate it with caution.
### Both space and time complexity will bubble unproportionally.
# def first_anagram_a?(str1, str2)
#     arr1, arr2 = string_split(str1), string_split(str2)
#     arr1.include?(str2.split(" "))
# end

# def string_split(str)
#     str_split = str.split("")
#     arr_str = str_split.permutation.to_a
#     # arr_str.map! { |ele| ele.join("") }
#     arr = arr_str.each_with_object([]) do |char, arr| 
#         arr << [char.join("")]
#     end
# end

### O(n!) Combinatorial/Factorial time
### O(n!) Combinatorial/Factorial space
### WARNING: These version can be dangerous. Activate it with caution.
### Both space and time complexity will bubble unproportionally.
def first_anagram_b?(str1, str2)
    gather_anagram(str1).include?(str2)
end

# using recursion would be nice here
def gather_anagram(string)
    return [string] if string.length <= 1
    # p string #=> Visualization purpose, don't delete
    prev_anagram = gather_anagram(string[0...-1])
    new_anagram = []

    prev_anagram.each do |anagram|
        (0..anagram.length).each do |i|
            # p string #=> Visualization purpose, don't delete
            new_anagram.push(anagram.dup.insert(i, string[-1]))
        end
    end

    new_anagram
end

##############################################################################################################################################

#===== Phase II =====

### O(n^2), Quadratic time
### O(n), Linear space
def second_anagram?(str1, str2)
    arr_str1, arr_str2 = str1.split(""), str2.split("")

    arr_str1.each do |char|
        target_idx = arr_str2.find_index(char)
        return false unless target_idx
        arr_str2.delete_at(target_idx)
    end

    arr_str2.length == 0
end

##############################################################################################################################################

#===== Phase III =====

### O(n*log(n)), Linearithmic time
### O(n), Linear space
def third_anagram?(str1, str2)
    # Divide and Conquer, remember?
    arr1, arr2 = str1.split(""), str2.split("")

    # Divide
    sorted_str = [arr1.sort, arr2.sort].map do |letter|
    # Conquer 
        letter.join
    end

    sorted_str[0] == sorted_str[-1]
end


##############################################################################################################################################

#===== Phase IV =====

=begin
Write one more method #fourth_anagram?

This time, use two Hashes to store the number of times 
each letter appears in both words.
Compare the resulting hashes.

BONUS: Do it with only one hash.

=end

### O(n), Linear time
### O(1), Constant space
def fourth_anagram?(str1, str2)
    letter_count1 = Hash.new(0)
    letter_count2 = Hash.new(0)

    str1.each_char { |char| letter_count1[char] += 1} 
    str2.each_char { |char| letter_count2[char] += 1 }
    # Here, the intuitive answer to the space complexity is
    # O(n) because we're adding a separate key in the hash
    # for each character. But if the keys in the hash are single 
    # characters, then how many different keys can we have? 
    # How many different chars in the alphabet? A constant number 
    # (26 + numbers and symbols for English alphabet).
    # It uses the "best case" here, because 26 numbers is
    # relatively small.

    letter_count1 == letter_count2
end

### O(n), Linear time
### O(1), Constant space
def fourth_anagram_one_hash?(str1, str2)
    letter_counts = Hash.new(0)

    # If we do the exact same subractions for each letter in
    # str2 as we do additions for str1, letter_sums will all be 0.
    str1.each_char { |char| letter_counts[char] += 1 }
    str2.each_char { |char| letter_counts[char] -= 1 }

    letter_counts.each_value.all? { |value| value == 0 }
end