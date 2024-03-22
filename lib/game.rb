'''
Main game
'''
require 'player'
require 'deck'

class Game
  attr_reader :players, :masterdeck, :bet_pot

  def initialize(player_count)
    @masterdeck = Deck.new
    @player_count = player_count
    @bet_pot = 0
    @players = []

    player_count.times do |x|
      puts "Player #{x + 1}, choose an initial investment."
      investment = gets.to_i
      @players << Player.new(@masterdeck.deal_cards, investment)
    end
  end
end
