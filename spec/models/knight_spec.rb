require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe 'valid_move?' do
    it 'should return true if piece moves in 2-1 L shape' do
      knight = FactoryGirl.create(:knight)
      expect(knight.valid_move?(3,2)).to eq true
    end

    it 'should return true if piece moves in 2-1 L shape backwards' do
      knight = FactoryGirl.create(:knight, row: 4, column: 4)
      expect(knight.valid_move?(2,3)).to eq true
    end

    it 'should not care about obstructions' do
      game = FactoryGirl.create(:game)
      knight = FactoryGirl.create(:knight, game_id: game.id)
      piece = FactoryGirl.create(:pawn, game_id: game.id, row: 2, column: 1)

      expect(knight.valid_move?(3,2)).to eq true
    end

    it 'should return false if piece moves any other way' do
      knight = FactoryGirl.create(:knight)
      expect(knight.valid_move?(3,3)).to eq false
    end

    it 'should return false if piece is moving in larger 2/1 jumps i.e. 4/2' do
      knight = FactoryGirl.create(:knight)
      expect(knight.valid_move?(5,3)).to eq false
    end
  end
end
