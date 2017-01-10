require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#show' do
    it 'should render game board for existing game' do
      game = FactoryGirl.create(:game)
      player = FactoryGirl.create(:player)
      sign_in player

      get :show, id: game.id
      expect(response).to have_http_status(:success)
    end

    it 'should render 404 if game does not exist' do
      player = FactoryGirl.create(:player)
      sign_in player

      get :show, id: 141231234309284
      expect(response).to have_http_status(:not_found)
    end
  end
end
