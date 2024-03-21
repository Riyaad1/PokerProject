'''
Hand Tests
'''

require 'hand'

RSpec.describe Hand do
  describe '.determine' do
    it 'Royal Flush' do
      royal_hand = Hand.new([Card.new('Clubs', '10'), Card.new('Clubs', 'Jack'), Card.new('Clubs', 'Queen'), Card.new('Clubs', 'King'), Card.new('Clubs', 'Ace')])
      royal_hand.determine
      expect(royal_hand.current_hand).to eq('Royal Flush')
    end
    it 'Straight Flush' do
      straight_hand = Hand.new([Card.new('Clubs', '2'), Card.new('Clubs', '3'), Card.new('Clubs', '4'), Card.new('Clubs', '5'), Card.new('Clubs', '6')])
      straight_hand.determine
      expect(straight_hand.current_hand).to eq('Straight Flush')
    end
    it 'Four-of-a-Kind' do
      four_hand = Hand.new([Card.new('Hearts', '6'), Card.new('Clubs', '6'), Card.new('Spades', '6'), Card.new('Diamonds', '6'), Card.new('Clubs', 'Jack')])
      four_hand.determine
      expect(four_hand.current_hand).to eq('Four-of-a-Kind')
    end
    it 'Full House' do
      full_hand = Hand.new([Card.new('Hearts', '4'), Card.new('Clubs', '4'), Card.new('Spades', '4'), Card.new('Diamonds', '8'), Card.new('Clubs', '8')])
      full_hand.determine
      expect(full_hand.current_hand).to eq('Full House')
    end
    it 'Flush' do
      flush_hand = Hand.new([Card.new('Clubs', '6'), Card.new('Clubs', '2'), Card.new('Clubs', '10'), Card.new('Clubs', '3'), Card.new('Clubs', 'Jack')])
      flush_hand.determine
      expect(flush_hand.current_hand).to eq('Flush')
    end
    it 'Straight' do
      straight_hand = Hand.new([Card.new('Hearts', '5'), Card.new('Clubs', '6'), Card.new('Spades', '7'), Card.new('Diamonds', '8'), Card.new('Clubs', '9')])
      straight_hand.determine
      expect(straight_hand.current_hand).to eq('Straight')
    end
    it 'Three-of-a-Kind' do
      three_hand = Hand.new([Card.new('Hearts', '4'), Card.new('Clubs', '4'), Card.new('Spades', '4'), Card.new('Diamonds', '8'), Card.new('Clubs', 'Jack')])
      three_hand.determine
      expect(three_hand.current_hand).to eq('Three-of-a-Kind')
    end
    it 'Two Pair' do
      two_hand = Hand.new([Card.new('Hearts', '5'), Card.new('Clubs', '5'), Card.new('Spades', '6'), Card.new('Diamonds', '6'), Card.new('Clubs', 'Jack')])
      two_hand.determine
      expect(two_hand.current_hand).to eq('Two Pair')
    end
    it 'One Pair' do
      one_hand = Hand.new([Card.new('Hearts', '5'), Card.new('Clubs', '5'), Card.new('Spades', '6'), Card.new('Diamonds', '8'), Card.new('Clubs', 'Jack')])
      one_hand.determine
      expect(one_hand.current_hand).to eq('One Pair')
    end
    it 'High Card' do
      high_hand = Hand.new([Card.new('Hearts', '4'), Card.new('Clubs', '5'), Card.new('Spades', '6'), Card.new('Diamonds', '8'), Card.new('Clubs', 'Jack')])
      high_hand.determine
      expect(high_hand.current_hand).to eq('High Card')
    end
  end
end
