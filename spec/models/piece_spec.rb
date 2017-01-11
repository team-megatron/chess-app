require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "is_obstructed?" do
    it "should return true if obstructed" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 2, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 3, game_id: game.id)

      # Test horizontal movement
      expect(moving_piece.is_obstructed?(1, 4)).to eq true
      moving_piece.update_column('column', 5)
      expect(moving_piece.is_obstructed?(1, 2)).to eq true
    end

    it "should return false if not obstructed" do
    end
  end

  describe "is_obstructed_horizontally?" do
    it "should return true if obstructed on horizontal move if moving piece is leftmost" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 2, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 3, game_id: game.id)

      expect(moving_piece.is_obstructed_horizontally?(5)).to eq true
    end

    it "should return true if obstructed on horizontal move if moving piece is rightmost" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 7, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 2, game_id: game.id)

      expect(moving_piece.is_obstructed_horizontally?(1)).to eq true
    end

    it "should return false if not obstructed on horizontal move if moving piece is leftmost" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 2, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 7, game_id: game.id)

      expect(moving_piece.is_obstructed_horizontally?(6)).to eq false
    end

    it "should return false if not obstructed on horizontal move if moving piece is rightmost" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 8, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 1, game_id: game.id)

      expect(moving_piece.is_obstructed_horizontally?(2)).to eq false
    end
  end

  describe "is_obstructed_diagonally?" do
    it "should return true if obstructed" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 1, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, row: 4, column: 4, game_id: game.id)

      expect(moving_piece.is_obstructed_diagonally?(5,5)).to eq true
    end

    it "should return false if obstructed" do

    end
  end
end
