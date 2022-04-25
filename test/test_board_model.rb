# frozen_string_literal: true

require_relative 'test_helper'
require_relative 'test_ship'
require_relative '../lib/board_model'
require 'test/unit'
require 'set'

class BoardModelTest < Test::Unit::TestCase
  def setup
    @small_board = BoardModel.new(8, 3) # chico
  end

  def test_out_of_bounds?
    assert_false(@small_board.out_of_bounds?(3, 1, 1, true))
    assert_true(@small_board.out_of_bounds?(3, 1, 7, false))
  end

  def test_ship_collision
    @small_board.board1[1][1] = 'S'
    @small_board.board2[1][1] = 'S'
    assert_true(@small_board.ship_collision?(3, 1, 1, true, 1))
    assert_true(@small_board.ship_collision?(3, 1, 1, false, 1))
    assert_false(@small_board.ship_collision?(3, 2, 2, true, 1))
  end

  def test_next_to_ship
    @small_board.board1[1][1] = 'S'
    assert_true(@small_board.next_to_ship?(3, 1, 2, true, 0))
    assert_false(@small_board.next_to_ship?(3, 1, 3, true, 0))
  end

  def test_valid_position
    assert_false(@small_board.valid_position(3, 20, 20, true, 1))
    assert_true(@small_board.valid_position(3, 2, 2, true, 1))
  end

  def test_add_ship
    ship = ShipClone.new(3, 2, 2, true)
    assert_equal([[2, 2], [3, 2], [4, 2]], @small_board.add_ship(1, ship))

    ship = ShipClone.new(3, 2, 2, false)
    assert_equal([[2, 2], [2, 3], [2, 4]], @small_board.add_ship(1, ship))
  end

  def test_update_sink_by
    ship = ShipClone.new(3, 2, 2, true)
    @small_board.update_sink_by(1, ship)
    ship_positions = [[2, 2], [3, 2], [4, 2]]
    ship_neighbors = [[1, 1], [1, 2], [1, 3], [2, 1], [2, 3], [3, 1], [3, 3], [4, 1], [4, 3], [5, 1], [5, 2], [5, 3]]
    ship_positions.each do |row, col|
      assert_equal(@small_board.board1[row][col], 'X')
    end
    ship_neighbors.each do |row, col|
      assert_equal(@small_board.board1[row][col], 'O')
    end
  end

  def test_valid_shot
    assert_true(@small_board.valid_shot(2, 2, 1))
  end

  def test_shot_from
    @small_board.board1[1][1] = 'S'
    assert_equal('!', @small_board.shot_from(1, 1, 1))
  end

  def test_neighbor_boxes
    # on the edge
    neighbors = [[1, 2], [2, 1], [2, 2]]
    boxes = @small_board.neighbor_boxes(1, 1, 1, true)
    assert_equal(neighbors.to_set, boxes.to_set)

    # on the center vertical
    neighbors = [[1, 2], [1, 3], [1, 4], [2, 2], [2, 4], [3, 2], [3, 3], [3, 4]]
    boxes = @small_board.neighbor_boxes(1, 2, 3, true)
    assert_equal(neighbors.to_set, boxes.to_set)

    # on the center horizontal
    neighbors = [[1, 2], [1, 3], [1, 4], [2, 2], [2, 4], [3, 2], [3, 3], [3, 4]]
    boxes = @small_board.neighbor_boxes(1, 2, 3, false)
    assert_equal(neighbors.to_set, boxes.to_set)
  end

  def test_vertical_neighbors
    neighbors = @small_board.vertical_neighbors 1, 1, 1
    actual_neighbors = [[0, 0], [1, 0], [2, 0], [0, 1], [2, 1], [0, 2], [1, 2], [2, 2]]
    assert_true(neighbors.to_set == actual_neighbors.to_set)
  end

  def test_horizontal_neighbors
    neighbors = @small_board.horizontal_neighbors 1, 1, 1
    actual_neighbors = [[0, 0], [1, 0], [2, 0], [0, 1], [2, 1], [0, 2], [1, 2], [2, 2]]
    assert_true(neighbors.to_set == actual_neighbors.to_set)
  end
end
