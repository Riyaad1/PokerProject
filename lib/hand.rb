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
    temp_storage = values.each_with_object(Hash.new(0)) { |x, y| y[x] += 1 }
    temp_storage.each { |_x, y| @current_hand = (y == 4)? 'Four-of-a-Kind' : 'Full House'; break }
  end

  def three_pairs(values)
    temp_storage = values.each_with_object(Hash.new(0)) { |x, y| y[x] += 1 }
    temp_storage = temp_storage.sort_by { |_key, value| value }.to_h
    @current_hand = (temp_storage.length == 3 && temp_storage[temp_storage.keys.last] != 3)? 'Two Pair' : (temp_storage.length == 4)? 'One Pair' : 'Three-of-a-Kind'
  end

  def straight_high(values)
    expectation = %w[2 3 4 5 6 7 8 9 10 11 12 13 14]
    @current_hand = (values.all? { |value| expectation.include?(value) } && values.max.to_i - values.min.to_i == 4)? 'Straight' : 'High Card'
  end
end
