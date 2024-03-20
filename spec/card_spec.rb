'''
Card Tests
'''

require 'card'

Rspec.describe Card do
  let(:new_card) { Card.new('Hearts', '2') }

  describe '#initialize' do
    it 'creates a card' do
      expect(new_card.suit).to eq('Hearts')
      expect(new_card.value).to eq('2')
    end
  end

  describe '.cardname' do
    context 'reads out the card' do
      it { expect(new_card.cardname).to eq('2 of Hearts') }
    end
  end
end
