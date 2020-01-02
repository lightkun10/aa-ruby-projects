class Board
  attr_accessor :cups

  def initialize(name1, name2)
      @name1 = name1
      @name2 = name2
      @cups = Array.new(14) { Array.new }
      # store cups: idx[6] & idx[13]
      place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, idx|
        next if idx == 6 || idx == 13
          place_stone = 0
          while place_stone < 4
              cup.push(:stone)
              place_stone += 1
          end
      end
  end

  def valid_move?(start_pos) # integer of starting position
      if start_pos < 0 || start_pos >= 13
          raise "Invalid starting cup" 
      end
      
      if @cups[start_pos].length == 0
          raise "Starting cup is empty"
      end
  end

  def make_move(start_pos, current_player_name) # int, str
      # take all the stones from the cup
      stones_in_hand = @cups[start_pos] # [:stone, :stone, :stone, :stone]
      # empties the cup
      @cups[start_pos] = []
      # distribute each(one) stone to every cups
        # UNTIL stone is all gone(empty)
      cup_idx = start_pos
      until stones_in_hand.empty?
            cup_idx += 1
            cup_idx = 0 if cup_idx > 13 # RESET
            # player 1
            if cup_idx == 6
                if current_player_name == @name1
                  @cups[6].push(stones_in_hand.pop)
                end
            # player 2
            elsif cup_idx == 13
                if current_player_name == @name2
                    @cups[13].push(stones_in_hand.pop)
                end
            else
              @cups[cup_idx].push(stones_in_hand.pop)
            end
      end
      render
      next_turn(cup_idx)
  end

  def next_turn(ending_cup_idx) # 5
    # helper method to determine whether #make_move returns 
    #   :switch, :prompt, or ending_cup_idx

    # p1/p2 cup store
    if ending_cup_idx == 6 || ending_cup_idx == 13
        :prompt
    elsif @cups[ending_cup_idx].count == 1
        :switch
    else
        ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
      @cups[0..5].all? { |cup| cup.empty? } ||
      @cups[7..12].all? { |cup| cup.empty? }
  end

  def winner
    player1_point = cups[6].count
    player2_point = cups[13].count

      if player1_point == player2_point
          return :draw
      else
          player1_point > player2_point ? @name1 : @name2
      end
  end
end

new_1 = Board.new("bod", "son")
# new_1.render
# new_1.make_move(12, "bod")
# new_1.cups
new_1.make_move(1, "bod")