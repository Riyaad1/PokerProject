'''
Holds the player deck and winning hands
'''

class Hand
  attr_reader :current_hand, :high_card, :player_deck, :values, :suits
  attr_writer :current_hand, :high_card, :player_deck

  RANKING = ['Royal Flush', 'Straight Flush', 'Four-of-a-Kind', 'Full House', 'Flush', 'Straight', 'Three-of-a-Kind', 'Two Pair', 'One Pair', 'High Card']

  def initialize(player_deck)
    faces = {'Jack' => '11', 'Queen' => '12', 'King' => '13', 'Ace' => '14'}
    @current_hand = ''
    @player_deck = player_deck
    @suits = @player_deck.map(&:suit)
    @values = @player_deck.map { |x| faces.key?(x.value) ? faces[x.value] : x.value }.sort_by(&:to_i).map(&:to_s)
    @high_card = @values[-1]
    self.determine
  end

  def determine
    unique_suits, unique_values = @suits.uniq, @values.uniq

    case
    when unique_suits.length == 1 then flushes(@values)
    when unique_values.length <= 2 then four_full(@values)
    when unique_values.length >= 3 && unique_values.length < 5 then three_pairs(@values)
    when unique_values.length == 5 then straight_high(@values)
    end
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
    temp_storage = temp_storage.sort_by { |_key, value| value }.to_h
    @current_hand = (temp_storage[temp_storage.keys.last] == 4)? 'Four-of-a-Kind': 'Full House'
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

  def fight(other)
    own_hand, other_hand = RANKING.index(@current_hand), RANKING.index(other.current_hand)
    return 'Win' if own_hand < other_hand || (own_hand == other_hand && @high_card > other.high_card)
    return 'Tie' if own_hand == other_hand && @high_card == other.high_card
    return 'Loss'
  end
end
