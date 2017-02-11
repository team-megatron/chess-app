require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe "pieces#update" do
    it "should return false when a white player moves a black piece" do
      white_player = FactoryGirl.create(:player)
      black_player = FactoryGirl.create(:player)
      sign_in white_player
      sign_in black_player

      game = FactoryGirl.create(:game, white_player_id: white_player.id,
                                black_player_id: black_player.id,
                                active_player_id: white_player.id)
      pawn = FactoryGirl.create(:pawn, is_black: true, game_id: game.id)

      patch :update, id: pawn.id, row: 2, column: 1, current_player_id: white_player.id

      pieces = Piece.where(row: 2, column: 1)
      expect(pieces.exists?).to eq false
      expect(pawn.game.active_player_id).to eq white_player.id
    end

    it "should return false when a non active player makes a move and no change turn" do
      white_player = FactoryGirl.create(:player)
      black_player = FactoryGirl.create(:player)
      sign_in white_player
      sign_in black_player

      game = FactoryGirl.create(:game, white_player_id: white_player.id,
                                black_player_id: black_player.id,
                                active_player_id: white_player.id)
      pawn = FactoryGirl.create(:pawn, is_black: false, game_id: game.id)

      patch :update, id: pawn.id, row: 2, column: 1, current_player_id: black_player.id

      pieces = Piece.where(row: 2, column: 1)
      expect(pieces.exists?).to eq false
      expect(pawn.game.active_player_id).to eq white_player.id
    end

    it "should return true when a active player makes a move and changes turn" do
      white_player = FactoryGirl.create(:player)
      black_player = FactoryGirl.create(:player)
      sign_in white_player
      sign_in black_player

      game = FactoryGirl.create(:game, white_player_id: white_player.id,
                                black_player_id: black_player.id,
                                active_player_id: white_player.id)
      pawn = FactoryGirl.create(:pawn, is_black: false, game_id: game.id)

      patch :update, id: pawn.id, row: 2, column: 1, current_player_id: white_player.id

      pieces = Piece.where(row: 2, column: 1)
      expect(pieces.exists?).to eq true
      expect(pawn.game.active_player_id).to eq black_player.id
    end

    it "should update the piece type if is_promotable? returns true" do
      white_player = FactoryGirl.create(:player)
      black_player = FactoryGirl.create(:player)
      sign_in white_player
      sign_in black_player

      game = FactoryGirl.create(:game, white_player_id: white_player.id,
                                black_player_id: black_player.id,
                                active_player_id: white_player.id)
      pawn = FactoryGirl.create(:pawn, row: 7, is_black: false, game_id: game.id)

      patch :update, id: pawn.id, row: 8, column: 1, new_type: 'Rook', current_player_id: white_player.id

      piece = Piece.find(pawn.id)
      expect(piece.type).to eq 'Rook'
    end

    it "should not update the piece type if is_promotable? returns false" do
      white_player = FactoryGirl.create(:player)
      black_player = FactoryGirl.create(:player)
      sign_in white_player
      sign_in black_player

      game = FactoryGirl.create(:game, white_player_id: white_player.id,
                                black_player_id: black_player.id,
                                active_player_id: white_player.id)
      pawn = FactoryGirl.create(:pawn, row: 6, is_black: false, game_id: game.id)

      patch :update, id: pawn.id, row: 7, column: 1, new_type: 'Rook', current_player_id: white_player.id

      piece = Piece.find(pawn.id)
      expect(piece.type).to eq 'Pawn'
    end

    it "should not promote a special piece on a promotion row" do
      white_player = FactoryGirl.create(:player)
      black_player = FactoryGirl.create(:player)
      sign_in white_player
      sign_in black_player

      game = FactoryGirl.create(:game, white_player_id: white_player.id,
                                black_player_id: black_player.id,
                                active_player_id: white_player.id)
      rook = FactoryGirl.create(:rook, row: 7, is_black: false, game_id: game.id)

      patch :update, id: rook.id, row: 8, column: 1, new_type: 'Queen', current_player_id: white_player.id

      piece = Piece.find(rook.id)
      expect(piece.type).to eq 'Rook'
    end
  end
end
