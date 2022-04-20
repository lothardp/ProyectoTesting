require_relative 'test_helper'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
  def test_winner
    board = Board.new # Verificar si al tablero no le quedan barcos
    assert_true(board.winner('1')) # Jugador que gano
  end

  def test_no_winner
    board = Board.new # Un tablero a que todavia le quedan barcos
    assert_false(board.winner('0'))
    assert_false(board.winner('X'))
  end
end
