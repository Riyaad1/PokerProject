'''
Defines the Cards
'''

class Card
  attr_reader :suit, :value
  attr_writer :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def card_readout
    return "#{self.value} of #{self.suit}"
  end
end
