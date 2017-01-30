require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "is_obstructed?" do
    it "should return true if obstructed moving horizontally" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 2, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 3, game_id: game.id)

      # Test horizontal movement
      expect(moving_piece.is_obstructed?(1,8)).to eq true
    end

    it "should return true if obstructed moving vertically" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, row: 2, column: 7, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, row: 4, column: 7, game_id: game.id)

      # Test horizontal movement
      expect(moving_piece.is_obstructed?(6,7)).to eq true
    end

    it "should return true if obstructed moving diagonally" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 1, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, row: 2, column: 2, game_id: game.id)

      # Test horizontal movement
      expect(moving_piece.is_obstructed?(4,4)).to eq true
    end

    it "should return false if not obstructed" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 2, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 4, game_id: game.id)

      # Test horizontal movement
      expect(moving_piece.is_obstructed?(1,3)).to eq false
    end
  end

  describe "is_obstructed_horizontally?" do
    it "should return true if obstructed on horizontal move if moving piece is leftmost" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 2, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 3, game_id: game.id)

      expect(moving_piece.is_obstructed_horizontally?(1,5)).to eq true
    end

    it "should return true if obstructed on horizontal move if moving piece is rightmost" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 7, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 2, game_id: game.id)

      expect(moving_piece.is_obstructed_horizontally?(1,1)).to eq true
    end

    it "should return false if not obstructed on horizontal move if moving piece is leftmost without obstruction" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 2, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 7, game_id: game.id)

      expect(moving_piece.is_obstructed_horizontally?(1,6)).to eq false
    end

    it "should return false if not obstructed on horizontal move if moving piece is rightmost without obstruction" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, column: 8, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, column: 1, game_id: game.id)

      expect(moving_piece.is_obstructed_horizontally?(1,3)).to eq false
    end
 end

 describe "is_obstructed_vertically?" do
   it "should return true if on vertical move if moving piece is below obstruction" do
     game = FactoryGirl.create(:game)
     moving_piece = FactoryGirl.create(:piece, row: 2, column: 4, game_id: game.id)
     obstructing_piece = FactoryGirl.create(:piece, row: 4, column: 4, game_id: game.id)

     expect(moving_piece.is_obstructed_vertically?(7,4)).to eq true
   end

   it "should return true if on vertical move if moving piece is above obstruction" do
     game = FactoryGirl.create(:game)
     moving_piece = FactoryGirl.create(:piece, row: 7, column: 5, game_id: game.id)
     obstructing_piece = FactoryGirl.create(:piece, row: 5, column: 5, game_id: game.id)

     expect(moving_piece.is_obstructed_vertically?(2,5)).to eq true
   end

   it "should return false if on vertical move without obstruction" do
    game = FactoryGirl.create(:game)
     moving_piece = FactoryGirl.create(:piece, row: 7, column: 5, game_id: game.id)
     obstructing_piece = FactoryGirl.create(:piece, row: 1, column: 5, game_id: game.id)

     expect(moving_piece.is_obstructed_vertically?(2,5)).to eq false
   end
 end

  describe "is_obstructed_diagonally?" do
    it "should return true if obstructed moving up and right" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, row: 1, column: 1, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, row: 4, column: 4, game_id: game.id)

      expect(moving_piece.is_obstructed_diagonally?(5,5)).to eq true
    end

    it "should return true if obstructed moving down and right" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, row: 7, column: 1, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, row: 5, column: 3, game_id: game.id)

      expect(moving_piece.is_obstructed_diagonally?(4,4)).to eq true
    end

    it "should return true if obstructed moving up and left" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, row: 1, column: 4, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, row: 2, column: 3, game_id: game.id)

      expect(moving_piece.is_obstructed_diagonally?(4,1)).to eq true
    end

    it "should return true if obstructed moving down and left" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, row: 6, column: 8, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, row: 4, column: 6, game_id: game.id)

      expect(moving_piece.is_obstructed_diagonally?(1,3)).to eq true
    end

    it "should return false if not obstructed diagonally" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:piece, row: 8, column: 8, game_id: game.id)
      obstructing_piece = FactoryGirl.create(:piece, row: 2, column: 2, game_id: game.id)

      expect(moving_piece.is_obstructed_diagonally?(3,3)).to eq false
    end
  end

  describe 'move_to' do
    it 'should record the move in the moves table' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, game_id: game.id)
      pawn.move_to(2,1)

      move = game.moves.last
      expect(move.piece_id).to eq pawn.id
      expect(move.start_row).to eq 1
      expect(move.start_column).to eq 1
      expect(move.end_row).to eq 2
      expect(move.end_column).to eq 1
    end

    it 'should set opponent piece to captured if capturable' do
      game = FactoryGirl.create(:game)
      black = FactoryGirl.create(:pawn, game_id: game.id)
      white = FactoryGirl.create(:pawn, game_id: game.id, row: 2, column: 2, is_black: false)

      expect(white.captured).to eq false

      black.move_to(2,2)
      white.reload
      expect(white.captured).to eq true
    end
  end

  describe "capture_piece" do
    it "should return true target square contains opponet piece" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:pawn, row: 8, column: 8, game_id: game.id)
      opponent_piece = FactoryGirl.create(:pawn, row: 7, column: 7, is_black:false ,game_id: game.id)

      expect(moving_piece.capturable?(7,7)).to eq true
    end

    it "should return false if target location contains same color piece" do
      game = FactoryGirl.create(:game)
      moving_piece = FactoryGirl.create(:pawn, game_id: game.id)
      same_color_piece = FactoryGirl.create(:pawn, row: 2, column: 2, game_id: game.id)

      expect(moving_piece.capturable?(2,2)).to eq false
    end
  end
end
