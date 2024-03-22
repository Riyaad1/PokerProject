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

  def player_choice(choice)
    case choice.upcase
    when 'RAISE'
      puts "You have chose to raise the bet\nYour current bet is: #{@player_bet}\nHow much will you raise by?"
      user_response = gets.to_i
      while @player_pot - user_response < 0
        puts 'Invalid value, enter a valid value'
        user_response = gets.to_i
      end
      @player_pot -= user_response
      @player_bet += user_response
      puts "Your bet is now: #{@player_bet}"
      return user_response
    when 'FOLD'

    when 'SEE'

    end
  end
end
