require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "is_obstructed?" do
    it "should return true if not obstructed" do
    end

    it "should return false if obstructed" do
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

    it "should return false if not obstructed on horizontal move if moving piece is leftmost without obstruction" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 2, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 7, game_id: game.id)

      expect(moving_piece.is_obstructed_horizontally?(6)).to eq false
    end

    it "should return false if not obstructed on horizontal move if moving piece is rightmost without obstruction" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 8, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 1, game_id: game.id)

      expect(moving_piece.is_obstructed_horizontally?(2)).to eq false
    end
 end

 describe "is_obstructed_vertically?" do
   it "should return true if on vertical move if moving piece is below obstruction" do
     game = FactoryGirl.create(:game)
     moving_piece = FactoryGirl.create(:piece, row: 2, column: 4, game_id: game.id)
     obstructing_piece = FactoryGirl.create(:piece, row: 4, column: 4, game_id: game.id)

     expect(moving_piece.is_obstructed_vertically?(7)).to eq true
   end

   it "should return true if on vertical move if moving piece is above obstruction" do
     game = FactoryGirl.create(:game)
     moving_piece = FactoryGirl.create(:piece, row: 7, column: 5, game_id: game.id)
     obstructing_piece = FactoryGirl.create(:piece, row: 5, column: 5, game_id: game.id)

     expect(moving_piece.is_obstructed_vertically?(2)).to eq true
   end

   it "should return false if on vertical move without obstruction" do
    game = FactoryGirl.create(:game)
     moving_piece = FactoryGirl.create(:piece, row: 7, column: 5, game_id: game.id)
     obstructing_piece = FactoryGirl.create(:piece, row: 1, column: 5, game_id: game.id)

     expect(moving_piece.is_obstructed_vertically?(2)).to eq false
   end
 end

  describe "is_obstructed_diagonally?" do
    it "should return true if move is up and right with obstruction" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, row: 3, column: 3,  game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, row: 7, column: 7, game_id: game.id)

      expect(moving_piece.is_obstructed_diagonally?(8, 8)).to eq true
    end

    it "should return false if moving up and right without obstruction" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, row: 3, column: 3,  game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, row: 7, column: 7, game_id: game.id)

      expect(moving_piece.is_obstructed_diagonally?(5, 5)).to eq false
    end

  end
end
