require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    it 'should return false if move is obstructed' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, game_id: game.id, row: 2, column: 2, is_black: false)
      other_piece = FactoryGirl.create(:knight, game_id: game.id, row: 3, column: 2, is_black: false)

      expect(pawn.valid_move?(4,2)).to eq false
    end

    it 'should return true if white pawn moves up one square' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, game_id: game.id, is_black: false)
      expect(pawn.valid_move?(2,1)).to eq true
    end

    it 'should return true if black pawn moves down once square' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, game_id: game.id, row: 7, column: 7)
      expect(pawn.valid_move?(6,7)).to eq true
    end

    it 'should return true if white pawn moves up two squares only on first move' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, game_id: game.id, row: 2, column: 1, is_black: false)
      expect(pawn.valid_move?(4, 1)).to eq true
    end

    it 'should return true if black pawn moves down two squares only on first move' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, game_id: game.id, row: 7, column: 1)
      expect(pawn.valid_move?(5,1)).to eq true
    end

    it 'should return false if white pawn tries to move two squares after first move' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, game_id: game.id, row: 3, column: 1, is_black: false)
      expect(pawn.valid_move?(5, 1)).to eq false
    end

    it 'should return false if black pawn tries to move two squares after first move' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, game_id: game.id, row: 6, column: 1)
      expect(pawn.valid_move?(4, 1)).to eq false
    end

    it 'should return false if white pawn move down' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, game_id: game.id, row: 2, column: 2, is_black: false)
      expect(pawn.valid_move?(1,2)).to eq false
    end

    it 'should return false if black pawn moves up' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, game_id: game.id, row: 7, column: 7)
      expect(pawn.valid_move?(8,7)).to eq false
    end

    it 'should return true if diagonal right move to square with opponent piece' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, is_black: false, game_id: game.id)
      piece = FactoryGirl.create(:queen, row: 2, column: 2, game_id: game.id)

      expect(pawn.valid_move?(2,2)).to eq true
    end

    it 'should return true if diagonal left move to square with opponent piece' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, column: 2, is_black: false, game_id: game.id)
      piece = FactoryGirl.create(:queen, row: 2, column: 1, game_id: game.id)

      expect(pawn.valid_move?(2,1)).to eq true
    end

    it 'should return false if diagonal move to square with same color piece' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, game_id: game.id, is_black: false)
      piece = FactoryGirl.create(:queen, row: 2, column: 2, game_id: game.id, is_black: false)

      expect(pawn.valid_move?(2,2)).to eq false
    end

    it 'should return false if diagonal move to empty square' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, is_black: false, game_id: game.id)
      expect(pawn.valid_move?(2,2)).to eq false
    end
  end
end
