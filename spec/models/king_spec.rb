require 'rails_helper'

RSpec.describe King, type: :model do
  describe "valid_move?" do
    it "should return true for a horizontal move of one space" do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:piece, row: 1, column: 5, game_id: game.id, type: 'King')
      
      expect(king.valid_move?(1,6)).to eq true
    end
    
    it "should return true for a vertical move of one space" do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:piece, row: 4, column: 5, game_id: game.id, type: 'King')
      
      expect(king.valid_move?(3,5)).to eq true
    end
    
    it "should return true for a diagonal move of one space" do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:piece, row: 3, column: 4, game_id: game.id, type: 'King')
      
      expect(king.valid_move?(2,3)).to eq true
    end
    
    it "should return FALSE for a move more than one space" do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:piece, row: 1, column: 2, game_id: game.id, type: 'King')
      
      expect(king.valid_move?(7,5)).to eq false
    end
  end
end
