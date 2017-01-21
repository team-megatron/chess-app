require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    it 'should return true if white pawn moves up one square' do
      pawn = FactoryGirl.create(:pawn, is_black: false)
      expect(pawn.valid_move?(2,2)).to eq true
    end

    it 'should return true if black pawn moves down once square' do
      pawn = FactoryGirl.create(:pawn, row: 7, column: 7)
      expect(pawn.valid_move?(6,6)).to eq true
    end

    it 'should return true if white pawn moves up two squares only on first move' do
      pawn = FactoryGirl.create(:pawn, row: 2, column: 1, is_black: false)
      expect(pawn.valid_move?(4, 1)).to eq true
    end

    it 'should return true if black pawn moves down two squares only on first move' do
      pawn = FactoryGirl.create(:pawn, row: 7, column: 1)
      expect(pawn.valid_move?(5,1)).to eq true
    end

    it 'should return false if white pawn tries to move two squares after first move' do
      pawn = FactoryGirl.create(:pawn, row: 3, column: 1, is_black: false)
      expect(pawn.valid_move?(5, 1)).to eq false
    end

    it 'should return false if black pawn tries to move two squares after first move' do
      pawn = FactoryGirl.create(:pawn, row: 6, column: 1)
      expect(pawn.valid_move?(4, 1)).to eq false
    end

    it 'should return true if diagonal move to square with oponent piece' do
      pawn = FactoryGirl.create(:pawn, is_black: false)
      piece = FactoryGirl.create(:queen, row: 2, column: 2)

      expect(pawn.valid_move?(2,2)).to eq true
    end

    it 'should return false if diagonal move to empty square' do
      pawn = FactoryGirl.create(:pawn, is_black: false)
      expect(pawn.valid_move?(2,2)).to eq false
    end
  end
end
