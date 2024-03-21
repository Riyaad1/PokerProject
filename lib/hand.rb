'''
Holds the player deck and winning hands
'''

class Hand
  attr_reader :current_hand, :high_card, :player_deck
  attr_writer :current_hand, :high_card, :player_deck

  RANKING = ['Royal Flush', 'Straight Flush', 'Four-of-a-Kind', 'Full House', 'Flush', 'Straight', 'Three-of-a-Kind', 'Two Pair', 'One Pair', 'High Card']

  def initialize(player_deck)
    @current_hand = ''
    @high_card = '0'
    @player_deck = player_deck
  end

  def determine
    suits = []
    values = []
    faces = {'Jack' => '11', 'Queen' => '12', 'King' => '13', 'Ace' => '14'}
    @player_deck.each do |x|
      suits << x.suit
      if faces.key?(x.value)
        values << faces[x.value]
      else
        values << x.value
      end
    end
    values.sort!
    # code to be written laster
  end

  def flushes(values)
    expectation = %w[2 3 4 5 6 7 8 9 10 11 12 13 14]
    royal_expectation = %w[10 11 12 13 14]
    if values.all? { |value| expectation.include?(value) } && values.max.to_i - values.min.to_i == 4
      @current_hand = (values == royal_expectation)? 'Royal Flush' : 'Straight Flush'
      return
    end
    @current_hand = 'Flush'
  end

  def four_full(values)
    temp_storage = Hash.new(0)
    values.each do |x|
      temp_storage[x] += 1
    end
    temp_storage.each do |_x, y|
      if y == 4
        @current_hand = 'Four-of-a-Kind'
        return
      else
        @current_hand = 'Full House'
        return
      end
    end
  end

  def three_pairs(values)
    temp_storage = Hash.new(0)
    values.each do |x|
      temp_storage[x] += 1
    end
    temp_storage = temp_storage.sort_by { |_key, value| value }.to_h
    if temp_storage.length == 3 && temp_storage[temp_storage.keys.last] != 3
      @current_hand = 'Two Pair'
      return
    elsif temp_storage.length == 4
      @current_hand = 'One Pair'
      return
    else
      @current_hand = 'Three-of-a-Kind'
    end
  end

  def straight_high(values)
    expectation = %w[2 3 4 5 6 7 8 9 10 11 12 13 14]
    if values.all? { |value| expectation.include?(value) } && values.max.to_i - values.min.to_i == 4
      @current_hand = 'Straight'
      return
    end
    @current_hand ='High Card'
  end
end
