# frozen_string_literal: true

class BoardModel
  attr_accessor :size, :positions, :n_ships, :board1, :board2

  def initialize(size, n_ships)
    @size = size
    @n_ships = n_ships
    @board1 = {}
    @board2 = {}
    build_boards
  end

  def build_boards
    # lista para testear
    (1..@size).each do |row|
      @board1[row] = {}
      @board2[row] = {}
      (1..@size).each do |col|
        @board1[row][col] = ' '
        @board2[row][col] = ' '
      end
    end
  end

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

  def add_ship(player, ship)
    board_to_add = player.zero? ? @board1 : @board2
    ship.positions.each { |row, col| board_to_add[row][col] = 'S' }
  end

  def shot_from(player, row, col)
    board_to_edit = player.zero? ? @board2 : @board1
    actual_symbol = board_to_edit[row][col]
    board_to_edit[row][col] = 'O' if actual_symbol == ' '
    board_to_edit[row][col] = '!' if actual_symbol == 'S'
  end

  def update_sink_by(player, ship)
    board_to_edit = player.zero? ? @board2 : @board1
    ship.positions.each do |row, col|
      board_to_edit[row][col] = 'X'
    end
  end
end
