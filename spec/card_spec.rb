'''
Card Tests
'''

require 'card'

RSpec.describe Card do
  let(:new_card) { Card.new('Hearts', '2') }

  describe '#initialize' do
    it 'creates a card' do
      expect(new_card.suit).to eq('Hearts')
      expect(new_card.value).to eq('2')
    end
  end

  describe '.card_readout' do
    context 'reads out the card' do
      it { expect(new_card.card_readout).to eq('2 of Hearts') }
    end
  end
end
