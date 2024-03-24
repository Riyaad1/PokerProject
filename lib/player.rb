'''
Defines the players
'''
require_relative 'hand'

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

  def player_choice(choice)
    case choice
    when 'RAISE'
      puts "You have chose to raise the bet\nYour current bet is: #{@player_bet}\nHow much will you raise by? "
      user_response = gets.to_i
      while @player_pot < user_response
        puts 'Invalid value, enter a valid value: '
        user_response = gets.to_i
      end
      @player_pot -= user_response
      @player_bet += user_response
      puts "Your bet is now: #{@player_bet}"
      return user_response
    when 'FOLD'
      puts 'You have chose to fold'
      @bet = 0
      @folded = true
      return self.discard(nil, 5)
    when 'SEE' # This doesn't do anything here, but does work in the game class to show the bet
      return 'SEE'
    end
  end
end
