require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe 'valid_move?' do
    before :each do
      @game = FactoryGirl.create(:game)
      @knight = FactoryGirl.create(:knight, game_id: @game.id)
    end

    it 'should return true if piece moves in 2-1 L shape' do
      expect(@knight.valid_move?(3,2)).to eq true
    end

    it 'should return true if piece moves in 2-1 L shape backwards' do
      expect(@knight.valid_move?(2,3)).to eq true
    end

    it 'should not care about obstructions' do
      piece = FactoryGirl.create(:pawn, game_id: @game.id, row: 2, column: 1)

      expect(@knight.valid_move?(3,2)).to eq true
    end

    it 'should return false if piece moves any other way' do
      expect(@knight.valid_move?(3,3)).to eq false
    end

    it 'should return false if piece is moving in larger 2/1 jumps i.e. 4/2' do
      expect(@knight.valid_move?(5,3)).to eq false
    end
  end
end
