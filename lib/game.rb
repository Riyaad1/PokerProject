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

  def player_turn(player, i)
    puts "Player #{i + 1}, choose to raise, see, or fold.\nYour current pot: #{player.player_pot}"
    user_response = gets.upcase
    until ['RAISE', 'FOLD', 'SEE'].include?(user_response)
      puts 'Invalid, try again'
      user_response = gets.upcase
    end
    action = player.player_choice(user_response)
    case user_response
    when 'SEE'
      puts "Current bet: #{@bet_pot}"
    when 'RAISE'
      @bet_pot += action
    when 'FOLD'
      @masterdeck.add_cards(action)
      @players[i] = nil
    end
  end

  def discard_choice(player)
    puts 'How many card will you discard? (1 - 3)'
    deletion_num = gets.to_i
    until(1..3).include?(deletion_num)
        puts 'Invalid, choose a valid value'
        deletion_num = gets.to_i
    end
    deletion_num.times do
      player.hand.player_deck.each_with_index do |card, index|
        puts "#{index + 1}. #{card.card_readout}"
      end
      puts 'Choose the card number'
      i = gets.to_i - 1
      @masterdeck.add_cards(player.discard(i))
      player.hand.player_deck << masterdeck.deal_cards.first
    end
  end

  def determine_win(player)
    remaining_players = []
    @players.each do |p|
      if p != nil
        remaining_players << p
      end
    end
    if remaining_players.length == 2
      if remaining_players.first == player
        return 'Current Player Wins' if player.hand.fight(remaining_players.last.hand) == 'Win'
        return 'Players Tie' if player.hand.fight(remaining_players.last.hand) == 'Tie'
        return 'Current Player Loses'
      else
        return 'Current Player Wins' if player.hand.fight(remaining_players.first.hand) == 'Win'
        return 'Players Tie' if player.hand.fight(remaining_players.first.hand) == 'Tie'
        return 'Current Player Loses'
      end
    end
  end
end
