# PHASE 2
def convert_to_int(str)
  begin
    int = Integer(str)
  rescue
    puts "Can't convert to Integer. Ensure that input is an integer."
  ensure
    int ||= 0
  end

  int
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

class NotAFruitError < StandardError
  def message
    "Hmm, not a fruit. But thanks anyway! * run away *"
  end
end

class GunError < StandardError
  def message
    "Do you expect me to \"I expect you to die!\" you, Mr. Bond?"
  end
end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit.downcase == 'gun'
    raise GunError
  else
    raise NotAFruitError
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  
  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue GunError => e
    puts e.message
    retry
  rescue NotAFruitError => e
      puts e.message
  end
end  


# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise ArgumentError.new("'name' cannot be blank. You have name, right friend?") if name.length <= 0
    raise ArgumentError.new("'yrs_known is less than 5. Friendship takes time, you know.'") if Integer(yrs_known) < 5
    raise ArgumentError.new("'fav_pastime' cannot be blank. C'mon, we do fun stuffs together, right?") if fav_pastime.length <= 0

    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


kub = BestFriend.new("Kubilai", 6, "Play DnD")
# p kub.give_friendship_bracelet