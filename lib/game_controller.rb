# frozen_string_literal: true

require_relative './ship'
require_relative './base_controller'

class GameController < BaseController
  attr_accessor :model

  def initialize(board_model, board_view)
    @model = board_model
    @view = board_view
    @turn = 0
    @winner = -1
    @ship_size = 3
    @row_to_int = { 'A' => 1, 'B' => 2, 'C' => 3, 'D' => 4, 'E' => 5, 'F' => 6,
                    'G' => 7, 'H' => 8, 'I' => 9, 'J' => 10, 'K' => 11, 'L' => 12 }
  end
  
  # fully tested
  def request_orientation
    orientation = 0
    while orientation != 1 && orientation != 2
      print "Select orientation\n 1) vertical\n 2) horizonal"
      orientation = stdin_get_integer(1)
    end
    orientation
  end
  
  # fully tested
  def request_row(board_size)
    row = 0
    while (row < 1) || (row > board_size)
      print 'Select a row: '
      r = stdin_get_string(10)
      @row_to_int[r].nil? ? next : row = @row_to_int[r]
    end
    row
  end

  # fully tested
  def request_column(board_size)
    col = 0
    while col < 1 || col > board_size
      print 'Select a column: '
      col = stdin_get_integer(20)
    end
    col
  end

  # funcion no se testea, ya que se testean las funciones por separado.
  # :nocov:
  def start_game(oponent)
    place_ships 0
    place_ships oponent
    play oponent
  end
  # :nocov:
  
  # falta linea del else.
  # :nocov:
  def place_ships(player) # rubocop:disable Metrics
    if player == 2 # AI
      place_ai_ships
      return
    end
    ship_counter = 0
    @view.print_one_side player
    while ship_counter < @model.n_ships
      ship_size = @ship_size # Podria ser al azar en vola
      print "\nSet a ship of size #{ship_size}"
      orientation = request_orientation
      row = request_row(@model.size)
      col = request_column(@model.size)
      if @model.valid_position(ship_size, row, col, orientation == 1, player)
        ship = Ship.new(ship_size, row, col, orientation == 1)
        @model.add_ship player, ship
        ship_counter += 1
      else
        print 'Invalid position, try another'
      end
      @view.print_one_side player
    end
  end
  # :nocov:
  
  def place_ai_ships
    ship_counter = 0
    while ship_counter < @model.n_ships
      print 'AI is setting its Ships'
      ship_size = @ship_size # Podria ser al azar en vola
      orientation = get_rand(2, 1)
      row = get_rand(1..@model.size, 4)
      col = get_rand(1..@model.size, 5)
      next unless @model.valid_position(ship_size, row, col, orientation == 1, 2)

      ship = Ship.new(ship_size, row, col, orientation == 1)
      @model.add_ship 2, ship
      ship_counter += 1
    end
  end
  
  def play(oponent)
    until win?
      play_turn @turn
      @turn = @turn.zero? ? oponent : 0
    end
    finish_game
  end
  
  def play_turn(player)
    if player == 2
      play_ai_turn
      return
    end
    @view.show_board_for player
    print 'Choose your shot'
    row, col = get_shot_from player
    hit, sunk_ship = handle_shot_from player, row, col
    @model.shot_from player, row, col
    @model.update_sink_by player, sunk_ship if sunk_ship
    @view.show_board_for player
    if hit
      print "It's a hit!"
      print 'You sunk a rival ship!' if sunk_ship
      return if win?

      print 'You can shoot again'
      play_turn player
    else
      print "It's a miss"
    end
  end
  
  def play_ai_turn
    print 'Press enter for AI to play'
    $stdin.gets
    row, col = get_shot_from 2
    hit, sunk_ship = handle_shot_from 1, row, col
    @model.shot_from 1, row, col
    @model.update_sink_by 1, sunk_ship if sunk_ship
    @view.show_board_for 0
    if hit
      print "It's a hit from the AI!"
      print 'The AI sunk one of your ships!' if sunk_ship
      return if win?

      print 'The AI can shoot again'
      play_turn 2
    else
      print "It's a miss"
    end
  end
  
  def get_shot_from(player)
    row = 0
    col = 0
    first = true
    until @model.valid_shot(row, col, player)
      print 'Invalid shot, already hit that box' if !first && player != 2
      row = player == 2 ? get_rand(1..@model.size, 4) : request_row(@model.size)
      col = player == 2 ? get_rand(1..@model.size, 5) : request_column(@model.size)
      first = false
    end
    [row, col]
  end
  
  def handle_shot_from(player, row, col)
    # returns (hit, sunk_ship)
    ships_to_check = player.zero? ? @model.p2_ships : @model.p1_ships
    ships_to_check.each do |ship|
      next unless ship.in? row, col

      ship.receive_hit_in row, col
      return true, ship if ship.sunk

      return true, nil
    end
    [false, nil]
  end
  
  def win?
    # returns true si alguien ya hundio todos los barcos del otro y setea winner
    @winner = 1
    @model.p1_ships.each do |ship|
      @winner = 0 unless ship.sunk
    end
    return true if @winner == 1

    @model.p2_ships.each do |ship|
      @winner = -1 unless ship.sunk
    end
    return true if @winner.zero?

    false
  end
  
  def finish_game
    winner_name = @winner.zero? ? 'Player 1' : 'Player 2'
    print "Game over! The winner is #{winner_name}"
  end
end
