'''
The deck containing cards
'''

require 'card'

class Deck
  attr_reader :deck, :first_turn
  attr_writer :first_turn

  def initialize
    @suits = ['Clubs', 'Spades', 'Hearts', 'Diamonds']
    @values = ['Ace', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King']
    @deck = @suits.product(@values).map { |suit, value| Card.new(suit, value) }
    @first_turn = false
  end
end
