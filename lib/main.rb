# frozen_string_literal: true

require_relative './two_player_controller'
require_relative './one_player_controller'
require_relative './board_view'
require_relative './board'
require_relative './ship'
require_relative './controller'

DIFFICULTY = Hash[1 => [8, 6], 2 => [12, 9]] # [board_size, number_of_ships]

controller = Controller.new(DIFFICULTY)
mode, diff = controller.welcome

model_p1 = Board.new(diff[0])
view_p1 = BoardView.new
model_p1.addObserver(view_p1)
model_p2 = Board.new(diff[0])
if mode == 1
    view_p2 = BoardView.new
    model_p2.addObserver(view_p2)
    game_controller = TwoPlayerController.new(model_p1, view_p1, model_p2, view_p2)
else
    game_controller = OnePlayerController.new(model_p1, view_p1, model_p2)
end
game_controller.put_ships(diff[1])

