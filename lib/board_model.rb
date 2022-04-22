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

  def out_of_bounds?(ship_size, row, col, is_vertical)
    statement = is_vertical ? row + ship_size - 1 > @size : col + ship_size - 1 > @size
    return statement || row < 1 || row > @size || col < 1 || col > @size
  end

  def ship_collision?(ship_size, row, col, is_vertical, player)
    board = player.zero? ? @board1 : @board2
    (0..(ship_size - 1)).each do |i|
      return true if is_vertical && board[row + i][col] == 'S'
      return true if !is_vertical && board[row][col + i] == 'S'
    end
    false
  end

  def valid_position(ship_size, row, col, is_vertical, player)
    return false if out_of_bounds?(ship_size, row, col, is_vertical) ||
                    ship_collision?(ship_size, row, col, is_vertical, player)

    true
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

  def valid_shot(row, col, player)
    return false if row == 0
    symbol = player.zero? ? @board2[row][col] : @board1[row][col]
    return false if symbol == 'O' || symbol == 'X' || symbol == '!'
    true
  end
end
