require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe "pieces#update" do
    it "should update the piece type if is_promotable? returns true" do
      player = FactoryGirl.create(:player)
      sign_in player

      game = FactoryGirl.create(:game, white_player_id: player.id)
      pawn = FactoryGirl.create(:pawn, row: 7, is_black: false, game_id: game.id)

      patch :update, id: pawn.id, row: 8, column: 1, new_type: 'Rook'

      piece = Piece.find(pawn.id)
      expect(piece.type).to eq 'Rook'
    end

    it "should not update the piece type if is_promotable? returns false" do
      player = FactoryGirl.create(:player)
      sign_in player

      game = FactoryGirl.create(:game, white_player_id: player.id)
      pawn = FactoryGirl.create(:pawn, row: 6, is_black: false, game_id: game.id)

      patch :update, id: pawn.id, row: 7, column: 1, new_type: 'Rook'

      piece = Piece.find(pawn.id)
      expect(piece.type).to eq 'Pawn'
    end

    it "should not promote a special piece on a promotion row" do
      player = FactoryGirl.create(:player)
      sign_in player

      game = FactoryGirl.create(:game, white_player_id: player.id)
      rook = FactoryGirl.create(:rook, row: 7, is_black: false, game_id: game.id)

      patch :update, id: rook.id, row: 8, column: 1, new_type: 'Queen'

      piece = Piece.find(rook.id)
      expect(piece.type).to eq 'Rook'
    end
  end
end
