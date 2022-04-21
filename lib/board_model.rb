# frozen_string_literal: true

require_relative './observable/observable'

class BoardModel < Observable
  attr_accessor :size, :positions, :n_ships

  def initialize(size, n_ships)
    super()
    @size = size
    @positions = {}
    @n_ships = n_ships
    build_board
  end

  def build_board
    # lista para testear
    (1..@size).each do |row|
      @positions[row] = {}
      (1..@size).each do |col|
        @positions[row][col] = ' '
      end
    end
    # change_board()
  end

  # def change_board()
  #     @positions[1][8] = "X"
  #     @positions[4][2] = "X"
  #     @positions[6][6] = "-"
  #     @positions[3][4] = "-"
  # end

  def out_of_bounds?(ship)
    (
        ship.bow['row'] < 1 || ship.bow['row'] > @size ||
        ship.bow['col'] < 1 || ship.bow['col'] > @size ||
        ship.stern['row'] > @size || ship.stern['col'] > @size
      )
  end

  def ship_collision(ship)
    ship.positions.each do |row, col| # [[1,2], [1,3], [1,4]]
      return true if @positions[row][col] == 'S'
    end
    false
  end

  def invalid_position(ship)
    return true if out_of_bounds?(ship) || ship_collision?(ship)

    false
  end

  def add_ship(ship)
    pos = ship.positions
    pos.each { |row, col| @positions[row][col] = 'S' }
    notifyAll
  end
end
