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
      allow_any_instance_of(Player).to receive(:gets).and_return(0, 500)
      new_game.first_turn(temp_player)
      expect(new_game.masterdeck.first_turn).to eq(false)
      expect(temp_player.player_pot).to eq(500)
    end
  end
end
