require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "populate_game!" do
    before :each do

    end

    it "should create all necessary pieces for a game of chess" do
      game = FactoryGirl.create(:game)
      game.populate_game!
      pieces = game.pieces

      expect(pieces.length).to eq 32
    end

    it "should create 8 pawns of each color" do
      game = FactoryGirl.create(:game)
      game.populate_game!
      pieces = game.pieces

      expect(pieces.where(type: 'Pawn', is_black: false).count).to eq 8
      expect(pieces.where(type: 'Pawn', is_black: true).count).to eq 8
    end

    it "should create two rooks, knights, and bishops for each color" do
      game = FactoryGirl.create(:game)
      game.populate_game!
      pieces = game.pieces

      expect(pieces.where(type: 'Rook', is_black: false).count).to eq 2
      expect(pieces.where(type: 'Knight', is_black: false).count).to eq 2
      expect(pieces.where(type: 'Bishop', is_black: false).count).to eq 2

      expect(pieces.where(type: 'Rook', is_black: true).count).to eq 2
      expect(pieces.where(type: 'Knight', is_black: true).count).to eq 2
      expect(pieces.where(type: 'Bishop', is_black: true).count).to eq 2
    end

    it "should create a king and queen for each color" do
      game = FactoryGirl.create(:game)
      game.populate_game!
      pieces = game.pieces

      expect(pieces.where(type: 'Queen', is_black: false).count).to eq 1
      expect(pieces.where(type: 'Queen', is_black: true).count).to eq 1

      expect(pieces.where(type: 'King', is_black: false).count).to eq 1
      expect(pieces.where(type: 'King', is_black: true).count).to eq 1
    end
  end
end
