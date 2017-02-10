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

    it 'should return true if white pawn makes valid en passant and mark opponent captured' do
      game = FactoryGirl.create(:game)
      white_pawn = FactoryGirl.create(:pawn, is_black: false, row: 5, column: 5, game_id: game.id)
      black_pawn = FactoryGirl.create(:pawn, is_black: true, row: 7, column: 6, game_id: game.id)

      black_pawn.move_to(5,6)

      expect(white_pawn.valid_move?(6,6)).to eq true

      black_pawn.reload
      expect(black_pawn.captured?).to eq true
    end
  
  end

  describe 'valid_en_passant?' do
    it 'should return true if white pawn can make valid en passant move' do
      game = FactoryGirl.create(:game)
      white_pawn = FactoryGirl.create(:pawn, is_black: false, row: 5, column: 5, game_id: game.id)
      black_pawn = FactoryGirl.create(:pawn, is_black: true, row: 7, column: 6, game_id: game.id)

      black_pawn.move_to(5,6)

      expect(white_pawn.valid_en_passant?(6,6)).to eq true
    end

    it 'should return true if black pawn can make valid en passant move' do
      game = FactoryGirl.create(:game)
      black_pawn = FactoryGirl.create(:pawn, is_black: true, row: 4, column: 2, game_id: game.id)
      white_pawn = FactoryGirl.create(:pawn, is_black: false, row: 2, column: 1, game_id: game.id)

      white_pawn.move_to(4,1)

      expect(black_pawn.valid_en_passant?(3,1)).to eq true
    end

    it 'should return false if this pawn cannot make valid en passant move because previous pawn made two 1 step moves' do
      game = FactoryGirl.create(:game)
      white_pawn = FactoryGirl.create(:pawn, is_black: false, row: 4, column: 5, game_id: game.id)
      black_pawn = FactoryGirl.create(:pawn, is_black: true, row: 7, column: 6, game_id: game.id)

      black_pawn.move_to(6,6)
      white_pawn.move_to(5,5)
      black_pawn.move_to(5,6)

      expect(white_pawn.valid_en_passant?(6,6)).to eq false
    end

    it 'should return false if pawn is going backwards trying to make an en passant move' do
      game = FactoryGirl.create(:game)
      white_pawn = FactoryGirl.create(:pawn, is_black: false, row: 5, column: 5, game_id: game.id)
      black_pawn = FactoryGirl.create(:pawn, is_black: true, row: 7, column: 6, game_id: game.id)

      black_pawn.move_to(5,6)

      expect(white_pawn.valid_en_passant?(4,6)).to eq false
    end
  end
  
  describe 'valid_en_passant? sub methods' do
    it 'should return FALSE if white pawn is on the incorrect row for en passant' do
      game = FactoryGirl.create(:game)
      white_pawn = FactoryGirl.create(:pawn, is_black: false, row: 3, column: 5, game_id: game.id)
      black_pawn = FactoryGirl.create(:pawn, is_black: true, row: 7, column: 6, game_id: game.id)
      white_pawn.move_to(4,5)
      black_pawn.move_to(5,6)
      
      
      expect(white_pawn.same_row_for_ep?).to eq false
    end
    
    it 'should return false if white pawn is moving to incorrect column for en passant' do
      game = FactoryGirl.create(:game)
      white_pawn = FactoryGirl.create(:pawn, is_black: false, row: 5, column: 5, game_id: game.id)
      black_pawn = FactoryGirl.create(:pawn, is_black: true, row: 7, column: 6, game_id: game.id)
      black_pawn.move_to(5,6)
      
      expect(white_pawn.same_column_for_ep?(4)).to eq false
    end
  end
end
