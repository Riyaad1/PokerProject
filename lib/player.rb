'''
Defines the players
'''
require 'hand'

class Player
  attr_reader :folded, :player_pot, :hand
  attr_writer :player_pot

  def initialize(player_deck, player_pot)
    @hand = Hand.new(player_deck)
    @player_pot = player_pot.to_i
    @player_bet = 0
    @folded = false
  end

  def discard(card_index, card_amount=1)
    case card_amount
    when 1
      return [@hand.player_deck.delete_at(card_index)]
    when 5 # Only when folding
      return Array.new(5) { @hand.player_deck.pop }
    end
  end

end
