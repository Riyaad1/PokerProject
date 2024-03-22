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
end
