require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe "pieces#update" do
    it "should update the piece type if is_promotable? returns true" do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, row: 7, is_black: false, game_id: game.id)

      player = FactoryGirl.create(:player)
      sign_in player

      patch :update, id: pawn.id, piece: {
        row: 8, column: 1, new_type: 'King'
      }

      pawn.reload
      expect(pawn.type).to eq 'King'
    end

    it "should not update the piece type if is_promotable? returns false" do

    end
  end
end
