'''
Game Tests
'''

require 'game'

RSpec.describe Game do
  let(:new_game) { Game.new(1) }

  describe '#initialize' do
    context 'creates players' do
      it  {
        allow_any_instance_of(Game).to receive(:gets).and_return(500)
        expect(new_game.players.length).to_not eq(0) }
    end
  end

  describe '.first_turn' do
    let(:temp_player) { Player.new([Card.new('Hearts', '4')], 1000)}
    it 'plays out the first turn' do
      allow_any_instance_of(Game).to receive(:gets).and_return(0, 500)
      new_game.first_turn(temp_player, 0)
      expect(new_game.masterdeck.first_turn).to eq(false)
      expect(temp_player.player_pot).to eq(500)
    end
  end

  describe '.player_turn' do
    let(:new_game) { Game.new(0) }
    let(:temp_player) { Player.new([Card.new('Hearts', '4')], 1000)}
    it 'captures users response to raises' do
      allow_any_instance_of(Game).to receive(:gets).and_return('raise')
      allow_any_instance_of(Player).to receive(:gets).and_return(100)
      new_game.player_turn(temp_player, 0)
      expect(new_game.bet_pot).to eq(100)
    end
    it 'captures users response to see' do
      allow_any_instance_of(Game).to receive(:gets).and_return('see')
      expect{new_game.player_turn(temp_player, 0)}.to output("Player 1, choose to raise, see, or fold.\nYour current pot: 1000\nCurrent bet: 0\n").to_stdout
    end
    it 'captures users response to fold' do
      allow_any_instance_of(Game).to receive(:gets).and_return('fold')
      new_game.player_turn(temp_player, 0)
      expect(temp_player.folded).to eq(true)
    end
  end
end
