# I use Ruby's `Set` class for collections I need to call `#include?`
# on; `#include?` is much faster on a `Set` than an `Array`. Don't
# worry, Arrays would work fine, too, just more slowly.
require 'set'

class WordChainer
    attr_reader :dictionary

    def initialize(dictionary_file_name)
        @dictionary = File.readlines(dictionary_file_name).map(&:chomp) # Array
        @dictionary = Set.new(@dictionary)
    end

    def run(source, target)
        @current_words = [source]
        
        # keys are new words, and 
        # value is the word we modified to get to the new word.
        @all_seen_words = { source => nil }

        until @current_words.empty?
            explore_current_words
        end

        build_path(target)
    end

    def adjacent_words(word) # array []
        adjacent = []
        word.each_char.with_index do |old_letter, i|
            ('a'..'z').each do |new_letter|
                next if old_letter == new_letter

                new_word = word.dup
                new_word[i] = new_letter

                if dictionary.include?(new_word)
                    adjacent << new_word
                end
            end
        end
        adjacent
    end

    def explore_current_words
    # I'm going to fill this up with new words (that aren't in @all_seen_words) 
    # that are adjacent (one step away) from a word in @current_words.
        new_current_words = []

        @current_words.each do |current_word|
            adjacent_words(current_word).each do |adjacent_word|
                next if @all_seen_words.key?(adjacent_word)

                new_current_words << adjacent_word

                # I record adjacent_word as the key, 
                # where the value is the current_word I came from.
                @all_seen_words[adjacent_word] = current_word
            end
        end
        # p new_current_words
        @current_words = new_current_words

        # new_current_words.each do |new_word|
        #     p "#{new_word} : from \"#{@all_seen_words[new_word]}\" "
        # end
    end

    def build_path(target)
        # p @all_seen_words
        path = []

        current_word = target
        
        until current_word.nil?
            path << current_word
            puts current_word = @all_seen_words[current_word]
        end
        path
    end
    
    
end

if $PROGRAM_NAME == __FILE__
    new_chain = WordChainer.new("dictionary.txt")
    p new_chain.run("market", "busted")
end