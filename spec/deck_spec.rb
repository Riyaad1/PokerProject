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
end
