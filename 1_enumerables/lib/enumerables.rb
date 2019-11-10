require 'byebug'

class Array
    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end


    def my_select(&prc)
        selected = []

        self.my_each do |e|
            selected << e if prc.call(e)
        end
        selected
    end


    def my_reject(&prc)
        rejected = []

        self.my_each do |e|
            rejected << e if !prc.call(e)
        end
        rejected
    end


    def my_any?(&prc)
        self.my_each do |e|
            return true if prc.call(e)
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |e|
            return false if !prc.call(e)
        end
        true
    end

    def my_flatten
        flattened = []

        self.my_each do |el|
            if el.is_a?(Array)
                flattened += el.my_flatten
            else
                flattened.push(el)
            end
        end

        flattened
    end

    def my_zip(*arrays)
        zip = []

        (0...self.length).each do |i|
            sub_zip = []
            sub_zip << self[i]

            arrays.each do |array|
                sub_zip << array[i]
            end

            zip << sub_zip
        end

        zip
    end

    def my_rotate(pos = 1)
        alphabet = ("a".."z").to_a
        rotated = []

        self.each_with_index do |letter, idx|
            new_pos = self[(idx + pos) % self.length]
            rotated << new_pos
        end

        rotated
    end

    def my_join(separator = "")
        join = ""

        (0...self.length).each do |i|
            join += self[i]
            join += separator if i != self.length - 1
        end

        join
    end

    def my_reverse
        reverse = []
        (self.length).times do |i|
            popped = self.pop()
            reverse << popped
        end

        reverse
    end

end