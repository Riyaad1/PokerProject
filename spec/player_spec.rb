'''
Player Tests
'''

require 'player'
require 'hand'
require 'card'

RSpec.describe Player do
  let(:new_player) { Player.new([Card.new('Hearts', '4')], 1000)}
  describe '.discard' do
    context 'removes a card back into the deck' do
      it { expect(new_player.discard(0, 1)).to_not eq(nil) }
    end
    context 'player folded so cards return back to deck' do
      it { expect(new_player.discard(0, 5).length).to eq(5) }
    end
  end
  describe '.player_choice' do
    it 'Raise' do
      allow_any_instance_of(Player).to receive(:gets).and_return(500)
      expect(new_player.player_choice('raise')).to eq(500)
    end
    it 'Fold' do
      allow_any_instance_of(Player).to receive(:gets).and_return(500)
      expect(new_player.player_choice('fold').length).to eq(5)
    end
    it 'See' do
      expect(new_player.player_choice('see')).to eq('SEE')
    end
  end
end
