'''
Main game
'''
require_relative 'player'
require_relative 'deck'

class Game
  attr_reader :players, :masterdeck, :bet_pot

  def initialize(player_count)
    @masterdeck = Deck.new
    @player_count = player_count
    @bet_pot = 0
    @players = []
    @masterdeck.first_turn = true

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
    user_response = gets.chomp.upcase
    until ['RAISE', 'FOLD', 'SEE'].include?(user_response)
      puts 'Invalid, try again'
      user_response = gets.chomp.upcase
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
    puts 'Will you discard cards this turn? (y/n)'
    user_response = gets.chomp.downcase
    until ['y', 'n'].include?(user_response)
      puts 'Invalid response, try again'
      user_response = gets.chomp.downcase
    end
    return if user_response == 'n'
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
    remaining_players = @players.compact
    if remaining_players.length == 2
      puts 'There are only two players left so the winner will be determined'
      opponent = remaining_players.find { |p| p != player }
      result = player.hand.fight(opponent.hand)
      return 'Current Player Wins' if result == 'Win'
      return 'Players Tie' if result == 'Tie'
      return 'Current Player Loses'
    end
  end

  def play #plays everything
    loop do
      @players.each_with_index do |player, i|
        puts "Player #{i + 1} Turn"
        if @masterdeck.first_turn == true
          self.first_turn(player, i)
        else
          self.player_turn(player, i)
          next if player.folded == true
          self.discard_choice(player)
          ending = self.determine_win(player)
          if ending != nil
            puts ending
            return
          end
        end
      end
    end
  end
end

#only 3 or more players, otherwise the game will determine the hand between the 2 players
game = Game.new(3)
game.play
