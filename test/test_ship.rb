# frozen_string_literal: true
require_relative 'test_helper'
require_relative '../lib/ship'
require 'test/unit'

# Se agrega accessor para hits
class ShipClone < Ship
  attr_accessor :hits
end

class BoardTest < Test::Unit::TestCase
  def setup
    @small_ship = ShipClone.new(1, 1, 1, true)
    @big_ship = ShipClone.new(2, 2, 3, false)
  end

  def test_is_in
    # Barco chico
    assert_true(@small_ship.is_in?(1, 1))

    assert_false(@small_ship.is_in?(2, 2))

    # Barco mediano
    assert_true(@big_ship.is_in?(2, 3))

    assert_true(@big_ship.is_in?(2, 4))

    assert_false(@big_ship.is_in?(3, 3))
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
end