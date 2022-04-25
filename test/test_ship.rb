# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/ship'
require 'test/unit'
require 'set'

# Se agrega accessor para hits
class ShipClone < Ship
  attr_accessor :hits
end

class BoardTest < Test::Unit::TestCase
  def setup
    @small_ship = ShipClone.new(1, 1, 1, true)
    @big_ship = ShipClone.new(2, 2, 3, false)
  end

  def test_in
    # Barco chico
    assert_true(@small_ship.in?(1, 1))

    assert_false(@small_ship.in?(2, 2))

    # Barco mediano
    assert_true(@big_ship.in?(2, 3))

    assert_true(@big_ship.in?(2, 4))

    assert_false(@big_ship.in?(3, 3))
  end

  def test_receive_hit_in
    # no hay hits
    assert_true(@small_ship.hits == [])

    # hit
    @small_ship.receive_hit_in(1, 1)
    assert_true(@small_ship.hits == [[1, 1]])

    # miss
    @small_ship.receive_hit_in(2, 2)
    assert_true(@small_ship.hits == [[1, 1]])
  end

  def test_vertical_neighbors
    neighbors = @small_ship.vertical_neighbors
    actual_neighbors = [[0, 0], [1, 0], [2, 0], [0, 1], [2, 1], [0, 2], [1, 2], [2, 2]]
    assert_true(neighbors.to_set == actual_neighbors.to_set)
  end

  def test_horizontal_neighbors
    neighbors = @big_ship.horizontal_neighbors
    actual_neighbors = [[1, 2], [2, 2], [3, 2], [1, 3], [3, 3], [1, 4], [3, 4], [1, 5], [2, 5], [3, 5]]
    assert_true(neighbors.to_set == actual_neighbors.to_set)
  end

  def test_clean_neighbors
    vertical_neighbors = [[0, 0], [1, 0], [2, 0], [0, 1], [2, 1], [0, 2], [1, 2], [2, 2]]
    neighbors = @small_ship.clean_neighbors vertical_neighbors, 8
    actual_neighbors = [[1, 2], [2, 1], [2, 2]]
    assert_true(neighbors.to_set == actual_neighbors.to_set)
  end

  def test_get_neighbors
    neighbors = @small_ship.get_neighbors 8
    actual_neighbors = [[1, 2], [2, 1], [2, 2]]
    assert_true(neighbors.to_set == actual_neighbors.to_set)
  end
end
