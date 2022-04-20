require_relative 'test_helper'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
  def setup
    # Inicialisar el tablero vacio, cambair board por variable que se utilice
    @board = Board.new
  end

  # shoot es la accion de poner algo, cambiar variable que se utilice

  def test_first_shot
    @board.shoot(0, 0, 'X') # X es como se vera el disparo en el tablero cambiar despues
    expected = Board.new # Un tablero marcado con X en 0, 0
    assert_true(@board.equal(expected))
  end

  ## Probar con turnos intercalados: second_mark pero ver como se modelan los tableros (hay mas de uno?)

  # Hacer dos tableros identicos y ver si son iguales

  def test_equal
    a = Board.new
    b = Board.new
    assert_true(a.equal(b))
  end

  # Hacer dos tableros diferentes y ver si son iguales

  def test_not_equal
    a = Board.new
    b = Board.new
    assert_false(a.equal(b))
  end
end
