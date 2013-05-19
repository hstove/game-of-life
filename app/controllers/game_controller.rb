class GameController < ApplicationController
  def new
    @board_size = params[:size] || 25
    @init_cells = params[:cells] || 200
  end
end
