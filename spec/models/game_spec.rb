require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "populate_game!" do
    it "should create all necessary pieces for a game of chess" do
      game = FactoryGirl.create(:game)
      game.populate_game!
      pieces = game.pieces
      expect(pieces.length).to eq 32
    end
  end
end
