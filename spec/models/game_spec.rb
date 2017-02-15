require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "populate_game!" do
    before :each do
      @game = FactoryGirl.create(:game)
      @game.populate_game!
    end

    it "should create all necessary pieces for a game of chess" do
      pieces = @game.pieces

      expect(pieces.length).to eq 32
    end

    it "should create 8 pawns of each color" do
      pieces = @game.pieces

      expect(pieces.where(type: 'Pawn', is_black: false).count).to eq 8
      expect(pieces.where(type: 'Pawn', is_black: true).count).to eq 8
    end

    it "should create two rooks, knights, and bishops for each color" do
      pieces = @game.pieces

      expect(pieces.where(type: 'Rook', is_black: false).count).to eq 2
      expect(pieces.where(type: 'Knight', is_black: false).count).to eq 2
      expect(pieces.where(type: 'Bishop', is_black: false).count).to eq 2

      expect(pieces.where(type: 'Rook', is_black: true).count).to eq 2
      expect(pieces.where(type: 'Knight', is_black: true).count).to eq 2
      expect(pieces.where(type: 'Bishop', is_black: true).count).to eq 2
    end

    it "should create a king and queen for each color" do
      pieces = @game.pieces

      expect(pieces.where(type: 'Queen', is_black: false).count).to eq 1
      expect(pieces.where(type: 'Queen', is_black: true).count).to eq 1

      expect(pieces.where(type: 'King', is_black: false).count).to eq 1
      expect(pieces.where(type: 'King', is_black: true).count).to eq 1
    end
  end

  describe 'player_in_check?' do
    it "should return true if opponent piece can move to king's square" do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, game_id: game.id)
      opponent = FactoryGirl.create(:rook, game_id: game.id, row: 1, column: 7, is_black: false)

      expect(game.player_in_check?(king.is_black?)).to eq true
    end

    it "should return false if no opponent piece can move to king's square" do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, game_id: game.id)
      opponent = FactoryGirl.create(:rook, game_id: game.id, row: 2, column: 7, is_black: false)

      expect(game.player_in_check?(king.is_black?)).to eq false
    end

    it "should return false if captured opponent piece can move to king's square" do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, game_id: game.id)
      opponent = FactoryGirl.create(:rook, game_id: game.id, row: 2, column: 1, is_black: false, captured: true)

      expect(game.player_in_check?(king.is_black?)).to eq false
    end
  end
  
  describe "draw?" do
    it "should return true if a piece moves to the same position 3 times" do
      game = FactoryGirl.create(:game)
      black_queen = FactoryGirl.create(:queen, game_id: game.id, row: 8, column: 4, is_black: true)
      white_bishop =FactoryGirl.create(:bishop, game_id: game.id, row: 1, column: 3, is_black: false)
      
      black_queen.move_to(6,4)
      white_bishop.move_to(3,1)
      black_queen.move_to(6,6)
      white_bishop.move_to(2,2)
      black_queen.move_to(6,4)
      white_bishop.move_to(5,5)
      black_queen.move_to(1,4)
      white_bishop.move_to(7,7)
      black_queen.move_to(6,4)
      
      expect(game.draw?).to eq true
      
    end
    
    describe "location_counts(piece)" do
      it "should return a hash table with a key of locations and value of times visited" do
        game = FactoryGirl.create(:game)
        black_queen = FactoryGirl.create(:queen, game_id: game.id, row: 8, column: 4, is_black: true)
        
        black_queen.move_to(4,4)
        black_queen.move_to(1,1)
        black_queen.move_to(4,4)
        
        expect(game.location_counts(black_queen)).to  eq({"4, 4"=>2, "1, 1"=>1}) 
      end
    end
  end
end
