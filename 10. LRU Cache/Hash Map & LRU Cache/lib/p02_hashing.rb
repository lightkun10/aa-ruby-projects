require 'byebug'

class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    each_with_index.inject(0) do |intermediate_hash, (ele, i)|
      (ele.hash + i.hash) ^ intermediate_hash
    end
  end
end

class String
  def hash
    temp_arr = []
    each_char { |char| temp_arr << char }
    encoded = temp_arr.map { |char| char.ord }

    encoded.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort_by(&:hash).hash
  end
end

# h = Hash.new(0)
# h["one"] = 1
# h["two"] = 2

# h2 = Hash.new(0)
# h2["two"] = 2
# h2["one"] = 1

# p h.hash == h2.hash