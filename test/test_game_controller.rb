# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board_model'
require_relative '../lib/board_view'
require_relative '../lib/game_controller'
require_relative 'test_ship'
require 'test/unit'
require 'set'
require 'stringio'

class BoardViewNoIO < BoardView
  attr_accessor :inputs

  def ask_for_orientation
    @inputs.pop.to_i
  end

  def ask_for_row
    @inputs.pop.to_s.chomp.upcase
  end

  def ask_for_column
    @inputs.pop.to_i
  end

  def ask_for_press_for_ai_play; end
end

class GameControllerNoIO < GameController
  def request_orientation
    orientation = 0
    orientation = rand(0..3) while orientation != 1 && orientation != 2
    orientation
  end

  def request_row(board_size)
    row = 0
    len = @row_to_int.length
    while (row < 1) || (row > board_size)
      r = @row_to_int.keys[rand(0..(len - 1))]
      @row_to_int[r].nil? ? next : row = @row_to_int[r]
    end
    row
  end

  def request_column(board_size)
    col = 0
    col = rand(1..(board_size * 2)) while col < 1 || col > board_size
    col
  end

  def play_turn(player, row, col)
    if player == 2
      play_ai_turn
      return
    end
    @view.show_board_for player
    hit, sunk_ship = handle_shot_from player, row, col
    @model.shot_from player, row, col
    @model.update_sink_by player, sunk_ship if sunk_ship
    @view.show_board_for player
    if hit
      puts "It's a hit!"
      puts 'You sunk a rival ship!' if sunk_ship
      return if win?

      puts 'You can shoot again'
      col += 1
      play_turn(player, row, col)
    else
      puts "It's a miss"
    end
  end
end

class GameControllerNoAI < GameController
  attr_accessor :call

  def play_ai_turn
    @call = true
  end
end

class GameControllerTest < Test::Unit::TestCase
  def setup
    @model = BoardModel.new(8, 3)
    @no_io_view = BoardViewNoIO.new(@model)
    @controller = GameController.new(@model, @no_io_view)
    @no_io_controller = GameControllerNoIO.new(@model, @no_io_view)
  end

  def test_place_ships_player
    positions = []
    @no_io_controller.place_ships 0
    @no_io_controller.model.p1_ships.each do |ship|
      positions += ship.positions
    end
    positions.each do |row, col|
      assert_equal(@model.board1[row][col], 'S')
    end
  end

  def test_place_ships_ai
    positions = []
    @no_io_controller.place_ships 2
    @no_io_controller.model.p2_ships.each do |ship|
      positions += ship.positions
    end
    positions.each do |row, col|
      assert_equal(@model.board2[row][col], 'S')
    end
  end

  def test_get_shot_from_player
    row, col = @no_io_controller.get_shot_from 0
    assert_true(row.positive?)
    assert_true(row <= @no_io_controller.model.size)
    assert_true(col.positive?)
    assert_true(col <= @no_io_controller.model.size)
  end

  def test_get_shot_from_ai
    row, col = @controller.get_shot_from 2
    assert_true(row.positive?)
    assert_true(row <= @controller.model.size)
    assert_true(col.positive?)
    assert_true(col <= @controller.model.size)
  end

  def test_handle_shot_from_player
    small_ship = ShipClone.new(1, 4, 6, true)
    big_ship = ShipClone.new(2, 6, 3, false)
    @model.add_ship(2, small_ship)
    @model.add_ship(2, big_ship)
    # hit and sunk
    statement, ship = @controller.handle_shot_from 0, 4, 6
    assert_true(statement)
    assert_equal(small_ship, ship)

    # hit and no sunk
    statement, ship = @controller.handle_shot_from 0, 6, 3
    assert_true(statement)
    assert_true(ship.nil?)

    # miss
    statement, ship = @controller.handle_shot_from 0, 1, 1
    assert_false(statement)
    assert_true(ship.nil?)
  end

  def test_handle_shot_from_ai
    small_ship = ShipClone.new(1, 4, 6, true)
    big_ship = ShipClone.new(2, 6, 3, false)
    @model.add_ship(0, small_ship)
    @model.add_ship(0, big_ship)
    # hit and sunk
    statement, ship = @controller.handle_shot_from 2, 4, 6
    assert_true(statement)
    assert_equal(small_ship, ship)

    # hit and no sunk
    statement, ship = @controller.handle_shot_from 2, 6, 3
    assert_true(statement)
    assert_true(ship.nil?)

    # miss
    statement, ship = @controller.handle_shot_from 2, 1, 1
    assert_false(statement)
    assert_true(ship.nil?)
  end

  def test_no_winner
    ship_p1 = ShipClone.new(1, 4, 4, true)
    ship_p2 = ShipClone.new(1, 6, 6, false)
    @model.add_ship(0, ship_p1)
    @model.add_ship(2, ship_p2)
    winner = @controller.win?
    assert_false(winner)
  end

  def test_winners # rubocop:disable Metrics
    ship_p1 = ShipClone.new(1, 4, 4, true)
    ship_p2 = ShipClone.new(1, 6, 6, false)
    @model.add_ship(0, ship_p1)
    @model.add_ship(2, ship_p2)
    # win p2
    @model.p1_ships[0].sunk = true
    winner = @controller.win?
    assert_true(winner)

    # win p1
    @model.p1_ships[0].sunk = false
    @model.p2_ships[0].sunk = true
    winner = @controller.win?
    assert_true(winner)
  end

  def test_play_player_turn
    ship = ShipClone.new(2, 3, 3, false)
    @model.add_ship(2, ship)
    # miss
    @no_io_controller.play_turn 0, 4, 3
    assert_equal(@no_io_controller.model.p2_ships[0].hits.to_set, [].to_set)
    assert_false(@no_io_controller.model.p2_ships[0].sunk)

    # hit
    # @no_io_controller.play_turn 0, 3, 3
    # assert_equal(@no_io_controller.model.p2_ships[0].hits.to_set,
    # @no_io_controller.model.p2_ships[0].positions.to_set)
  end

  def test_request_orientation
    @no_io_view.inputs = ['0', '1', 'dasfa', 'lol ', '2', 'hoasdlfasd']

    first = @controller.request_orientation
    second = @controller.request_orientation
    assert_equal(first, 2)
    assert_equal(second, 1)
  end

  def test_request_row
    @no_io_view.inputs = %w[b 1 z a 2 hoasdlfasd]

    first = @controller.request_row @model.size
    second = @controller.request_row @model.size
    assert_equal(first, 1)
    assert_equal(second, 2)
  end

  def test_request_column
    @no_io_view.inputs = %w[lol 5 3 X hola 2 chao]

    first = @controller.request_column @model.size
    second = @controller.request_column @model.size
    assert_equal(first, 2)
    assert_equal(second, 3)
  end

  def test_play_turn
    @no_io_view.inputs = %w[1 e 2 1 c 2 1 a 2]
    @controller.place_ships 1
    @no_io_view.inputs = %w[1 e 2 1 c 2 1 a 2]
    @controller.place_ships 0
    @no_io_view.inputs = %w[5 a 3 a 2 a 1 a]
    @controller.play_turn 0
    assert_true(@model.p2_ships[0].sunk)
  end

  def test_play_turn_ai_turn
    no_ai_controller = GameControllerNoAI.new @model, @no_io_view
    no_ai_controller.play_turn 2
    assert_true(no_ai_controller.call)
  end

  def test_play_ai_turn; end

  def test_finish_game; end

  def test_play; end

  def test_start_game; end
end
