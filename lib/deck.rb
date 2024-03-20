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

  def deal_cards
    deal_list = []
    if @first_turn
      5.times do
        deal_list << @deck.pop
      end
    else
      deal_list << @deck.pop
    end
    return deal_list
  end

  def shuffle_deck
    @deck.shuffle!
  end

  def add_cards(card_list)
    card_list.each do |card|
      @deck << card
    end
  end
end
