'''
Deck Tests
'''

require 'deck'

RSpec.describe Deck do
  let(:new_deck) { Deck.new }

  describe '#initialize' do
    context 'sets up deck' do
      it { expect(new_deck.deck.length).to_not eq(1) }
    end
  end

  describe '.deal' do
    it 'deals cards first round' do
      new_deck.first_turn = true
      expect(new_deck.deal.length).to eq(5)
    end
    context 'deals cards other rounds' do
      it { expect(new_deck.deal.length).to eq(1) }
    end
  end
end
