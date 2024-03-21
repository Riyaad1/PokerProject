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
  end

  def flushes

  end

  def four_full

  end

  def three_pairs

  end

  def straight_high

  end
end
