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
    @deck = []
    @first_turn = false

    @suits.product(@values) do |x, y|
      @deck << Card.new(x, y)
    end
  end
end
