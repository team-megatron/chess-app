require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe "valid_move?" do
    it "should return true for horizontal move" do
      game = FactoryGirl.create(:game)
      rook = FactoryGirl.create(:rook, row: 1, column: 1, game_id: game.id)
      
      expect(rook.valid_move?(1,7)).to eq true
    end
    
    it "should return true for a vertical move" do
      game = FactoryGirl.create(:game)
      rook = FactoryGirl.create(:rook, row: 1, column: 8, game_id: game.id)
      
      expect(rook.valid_move?(7,8)).to eq true
    end
    
    it "should return FALSE for non horizontal or vertical move" do
      game = FactoryGirl.create(:game)
      rook = FactoryGirl.create(:rook, row: 8, column: 8, game_id: game.id)
      
      expect(rook.valid_move?(5,5)).to eq false
    end
  end
end
