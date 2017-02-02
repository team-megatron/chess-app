require 'rails_helper'

RSpec.describe King, type: :model do
  describe "valid_move?" do
    it "should return true for a horizontal move of one space" do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, row: 1, column: 4, game_id: game.id)

      expect(king.valid_move?(1,5)).to eq true
    end

    it "should return true for a vertical move of one space" do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, row: 4, column: 4, game_id: game.id)

      expect(king.valid_move?(3,4)).to eq true
    end

    it "should return true for a diagonal move of one space" do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, row: 3, column: 4, game_id: game.id)

      expect(king.valid_move?(2,3)).to eq true
    end

    it "should return FALSE for a move more than one space" do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, row: 1, column: 2, game_id: game.id)

      expect(king.valid_move?(7,5)).to eq false
    end

    it 'should return true if the king can make a valid castle move' do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, game_id: game.id, row: 8, column: 5)
      rook = FactoryGirl.create(:rook, game_id: game.id, row: 8, column: 1)

      expect(king.valid_move?(8,1)).to eq true
    end
  end

  describe "can_castle?()" do
    before :each do
      @game = FactoryGirl.create(:game)
      @king = FactoryGirl.create(:king, game_id: @game.id, row: 8, column: 5)
      @rook = FactoryGirl.create(:rook, game_id: @game.id, row: 8, column: 1)
    end

    it "should return true if king and rook have not moved" do
      expect(@king.can_castle? @rook.row, @rook.column).to eq true
    end

    it "should return false if king has already moved" do
      @king.move_to(8,4)
      expect(@king.can_castle? @rook.row, @rook.column).to eq false
    end

    it "should return false if rook has already moved" do
      @rook.move_to(8,2)
      expect(@king.can_castle? @rook.row, @rook.column).to eq false
    end

    it "should return false if a piece is between the king and rook" do
      obstructing_piece = FactoryGirl.create(:knight, game_id: @game.id, row: 8, column: 2)
      expect(@king.can_castle? @rook.row, @rook.column).to eq false
    end

    it "shoudl return false if no piece is at rook start" do
      @rook.update_attributes(row: 5, column: 5)
      expect(@king.can_castle? 8, 1).to eq false
    end
  end

  describe "move_to()" do
    before :each do
      @game = FactoryGirl.create(:game)
      @king = FactoryGirl.create(:king, game_id: @game.id, row: 8, column: 5)
      @left_rook = FactoryGirl.create(:rook, game_id: @game.id, row: 8, column: 1)
      @right_rook = FactoryGirl.create(:rook, game_id: @game.id, row: 8, column: 8)
    end

    it 'should call super if king is not castling' do
      @king.move_to 8,4
      @king.reload

      expect(@king.row).to eq 8
      expect(@king.column).to eq 4
    end

    it 'should move king two squares left and rook one square to its right' do
      @king.move_to 8,1
      @king.reload
      @left_rook.reload

      expect([@king.row, @king.column]).to eq [8,3]
      expect([@left_rook.row, @left_rook.column]).to eq [8,4]
    end

    it 'should move king two squares right and rook one square to its left' do
      @king.move_to 8,8
      @king.reload
      @right_rook.reload

      expect([@king.row, @king.column]).to eq [8,7]
      expect([@right_rook.row, @right_rook.column]).to eq [8,6]
    end
  end
end
