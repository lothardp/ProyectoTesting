# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/welcome_controller'
require 'test/unit'

class WelcomeControllerNoIO < WelcomeController
  def set_input_map(input_map) # rubocop:disable Naming
    @input_map = input_map
  end

  def stdin_get_integer(var)
    @input_map[var]
  end
end

class WelcomeTest < Test::Unit::TestCase
  def setup
    # A new controller
    @board = WelcomeControllerNoIO.new(Hash[1 => [8, 3], 2 => [12, 7]])
  end

  def test_correct_mode
    # Stub for stdin
    expected_mode = 1
    input_map = Hash[1 => expected_mode, 2 => 1]
    # Stub IO
    @board.set_input_map(input_map)
    mode, = @board.welcome
    assert_true(mode == expected_mode)
  end

  # To Do:
  # - Agregar test para función stdin_get_integer
  # - Agregar caso que el modo este incorrecto (loop infinito por el map)
end
