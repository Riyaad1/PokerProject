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
      @players << Player.new(@masterdeck.deal_cards, gets.to_i)
    end
  end

  def first_turn(player, i)
    puts "Player #{i + 1}, place the first bet."
    user_response = gets.to_i
    while user_response > player.player_pot
        puts 'Invalid bet, try again'
        user_response = gets.to_i
    end
    player.player_pot -= user_response
    @masterdeck.first_turn = false
    @bet_pot += user_response
  end
end
