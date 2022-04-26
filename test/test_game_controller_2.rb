# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board_model'
require_relative '../lib/board_view'
require_relative '../lib/game_controller'
require 'test/unit'

class GameControllerNoIO < GameController
  attr_accessor :ship_size, :winner

  def set_step(step = 0)
    @step = step
  end

  # 1 para orientacion
  # 10 para fila (letra)
  # 20 para columna
  def set_input_map(input_map) # rubocop:disable Naming
    @input_map = input_map
  end

  def stdin_get_integer(var)
    @input_map[var + @step]
  end

  def stdin_get_string(var)
    @input_map[var + @step]
  end

  def get_rand(_range, var)
    @input_map[var + @step]
  end
end

class GameControllerTest < Test::Unit::TestCase
  def setup
    # controlador vacio.
    @model_1 = BoardModel.new(8, 3)
    @view_1 = BoardView.new(@model_1)
    @controller_1 = GameControllerNoIO.new(@model_1, @view_1)
    @controller_1.set_step

    # controlador con inicio seteado y barcos de largo 1
    # @model_2 = BoardModel.new(8, 3)
    # @view_2 = BoardView.new(@model_2)
    # @controller_2 = GameControllerNoIO.new(@model_2, @view_2)
    # @controller_2.model.n_ships = 1
    # @controller_2.ship_size = 1
    # @controller_2.set_input_map({1 => 1, 2 => 'B', 3 => 2, 4 => 2, 5 => 2})
    # @controller_2.place_ships(0)
    # @controller_2.place_ships(2)
    # @controller_2.set_input_map(nil)

    # controlador con inicio seteado y barcos de largo 2.
    # @model_3 = BoardModel.new(8, 3)
    # @view_3 = BoardView.new(@model_3)
    # @controller_3 = GameControllerNoIO.new(@model_3, @view_3)
    # @controller_3.model.n_ships = 1
    # @controller_3.ship_size = 2
    # @controller_3.set_input_map({1 => 1, 2 => 'B', 3 => 2, 4 => 2, 5 => 2})
    # @controller_3.place_ships(0)
    # @controller_3.place_ships(2)
    # @controller_3.set_input_map(nil)

    # controlador con overwrite de request_row
    # @model_4 = BoardModel.new(8, 3)
    # @view_4 = BoardView.new(@model_4)
    # @controller_4 = GameControllerSetRow.new(@model_4, @view_4)
  end

  def test_request_orientation
    # orientacion factible
    expected_orientation = 1
    @controller_1.set_input_map({ 1 => expected_orientation })

    orientation = @controller_1.request_orientation
    assert_true(orientation == expected_orientation)
  end

  def test_request_row
    expected_row = 2
    @controller_1.set_input_map({ 10 => 'L', 11 => 'B' })

    row = @controller_1.request_row(8)
    assert_true(row == expected_row)
  end

  # def test_request_column
  #  expected_column = 2
  #  @controller_1.set_input_map({3 => 2})

  #  column = @controller_1.request_column(8)
  #  assert_true(column == expected_column)
  # #end

  # #def test_place_ships_1
  ##  @controller_1.model.n_ships = 1
  # barco va en 1, B
  ##  @controller_1.set_input_map({1 => 1, 2 => 'B', 3 => 2, 4 => 2, 5 => 2})
  ##  @controller_1.place_ships(0)
  ##  @controller_1.place_ships(2)
  # #end

  # #def test_place_ships_2
  ##  @controller_4.model.n_ships = 1
  ##  @controller_4.set_input_map({1 => 1, 2 => 'B'})
  ##  @controller_4.place_ships(0)
  # #end

  # #def test_get_shot_from
  # de IA
  ##  expected_shot = [2, 2]
  ##  @controller_2.set_input_map({4 => 2, 5 => 2})
  ##  shot = @controller_2.get_shot_from(2)
  ##  assert_true(shot == expected_shot)

  # de usuario
  ##  @controller_2.set_input_map({2 => 'B', 3 => 2})
  ##  shot = @controller_2.get_shot_from(0)
  ##  assert_true(shot == expected_shot)
  # #end

  # #def test_handle_shot
  # se le pegó a un barco y se hundió
  ##  shot, ship = @controller_2.handle_shot_from(0, 2, 2)
  ##  assert_true(shot)
  ##  assert_false(ship == nil)

  # no se le pegó a un barco
  ##  shot, ship = @controller_2.handle_shot_from(0, 3, 2)
  ##  assert_false(shot)
  ##  assert_true(ship == nil)

  # Se le pegó a un barco y no se hundió
  ##  shot, ship = @controller_3.handle_shot_from(0, 2, 2)
  ##  assert_true(shot)
  ##  assert_true(ship == nil)
  # #end

  # Se testea por jugador para aprovechar el setup
  # #def test_win_player_1
  # no hay ganador
  ##  win = @controller_2.win?
  #  assert_false(win)

  # gana jugador 1
  #  @controller_2.handle_shot_from(0, 2, 2)
  #  win = @controller_2.win?
  #  assert_true(win)

  # ganador
  #  @controller_2.finish_game
  #  assert_true(@controller_2.winner == 0)
  # end

  # Se testea por jugador para aprovechar el setup
  # def test_win_player_2
  # no hay ganador
  #  win = @controller_2.win?
  #  assert_false(win)

  # gana jugador 1
  #  @controller_2.handle_shot_from(2, 2, 2)
  #  win = @controller_2.win?
  #  assert_true(win)

  # ganador
  #  @controller_2.finish_game
  #  assert_true(@controller_2.winner == 1)
  # end

  # def test_play_turn
  #  @controller_1.model.n_ships = 1
  #  @controller_1.ship_size = 1
  #  @controller_1.set_input_map({1 => 1, 2 => 'B', 3 => 2})
  #  @controller_1.place_ships(0)
  #  @controller_1.place_ships(2)
  #  @controller_1.play(2)
  # end
end
