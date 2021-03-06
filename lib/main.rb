# frozen_string_literal: true

require_relative './game_controller'
require_relative './board_view'
require_relative './board_model'
require_relative './ship'
require_relative './welcome_controller'

DIFFICULTY = Hash[1 => [8, 3], 2 => [12, 7]] # [board_size, number_of_ships]

controller = WelcomeController.new(DIFFICULTY)
mode, board_size, n_ships = controller.welcome

# Se crea el modelo de la board que contiene ambos tableros
board_model = BoardModel.new(board_size, n_ships)

# Crear la vista
board_view = BoardView.new board_model

# Crear controlador del juego segun cantidad de jugadores
game_controller = GameController.new(board_model, board_view)
game_controller.start_game(mode)
