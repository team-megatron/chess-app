require 'rails_helper'

RSpec.describe Bishop, type: :model do
  describe 'valid_move?' do
    it "should should return true when moving diagonally" do
      game = FactoryGirl.create(:game)
      bishop = FactoryGirl.create(:bishop, row: 1, column: 3, game_id: game.id)

      expect(bishop.valid_move?(4, 6)).to eq true
      expect(bishop.valid_move?(2, 4)).to eq true
    end

    it "should return false when moving horizontal" do
      game = FactoryGirl.create(:game)
      bishop = FactoryGirl.create(:bishop, row: 1, column: 6, game_id: game.id)

      expect(bishop.valid_move?(1, 3)).to eq false
      expect(bishop.valid_move?(1, 7)).to eq false
    end

    it "should return false when moving vertical" do
      game = FactoryGirl.create(:game)
      bishop = FactoryGirl.create(:bishop, row: 1, column: 6, game_id: game.id)

      expect(bishop.valid_move?(5, 6)).to eq false
      expect(bishop.valid_move?(3, 6)).to eq false
    end

    it "should return false when moving outside of board" do
      game = FactoryGirl.create(:game)
      bishop = FactoryGirl.create(:bishop, row: 1, column: 6, game_id: game.id)

      expect(bishop.valid_move?(4, 9)).to eq false
      expect(bishop.valid_move?(0, 5)).to eq false
    end
  end
end
