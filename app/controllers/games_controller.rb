class GamesController < ApplicationController
  
  def new
    @game = Game.new
  end
  
  def show
    @game = Game.find_by_id(params[:id])
    return render_not_found if @game.blank?
  end
  
end
