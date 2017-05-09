class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14){Array.new}
    @name1 = name1
    @name2 = name2
    place_stones


  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    # @cups.each_with_index do |cup ,i|
       @cups.each_with_index do |cup, idx|
     next if idx == 6 || idx == 13
     4.times do
       cup << :stone
     end
   end
   @cups
  end

  def valid_move?(start_pos)

    raise 'Invalid starting cup' if start_pos>13 || start_pos < 1
  end

  def make_move(start_pos, current_player_name)

   stones = @cups[start_pos]
   @cups[start_pos] = []


   cup_idx = start_pos
   until stones.empty?
     cup_idx += 1
     cup_idx = 0 if cup_idx > 13
     if cup_idx == 6
       @cups[6] << stones.pop if current_player_name == @name1
     elsif cup_idx == 13
       @cups[13] << stones.pop if current_player_name == @name2
     else
       @cups[cup_idx] << stones.pop
     end
   end

   render
   next_turn(cup_idx)
  end

  def next_turn(ending_cup_idx)
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
    return true if @cups[0...6].all?{|cup| cup.empty?} || @cups[7...-1].all?{|cup| cup.empty?}
    false
  end

  def winner
    player1_cup = @cups[6].count
    player2_cup = @cups[13].count
    if player1_cup > player2_cup
      @name1
    elsif player2_cup > player1_cup
      @name2
    else
      :draw
    end

  end

end
