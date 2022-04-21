# frozen_string_literal: true

require_relative './player_controller'

class TwoPlayerController < PlayerController
  def initialize(board_model_p1, board_view, board_model_p2, board_view_p2)
    super()
    @model_p1 = board_model_p1
    @view_p1 = board_view
    @model_p2 = board_model_p2
    @view_p2 = board_view_p2
  end

  def request_ships(n_ships)
    # empieza los inputs para colocar el barco
  end
end
