# frozen_string_literal: true

require_relative './player_controller'

class OnePlayerController < PlayerController
  def initialize(board_model, board_view)
    super()
    @model = board_model
    @view = board_view
    @turn = 0
    @winner = -1
  end

  def start_game
    set_ships 0
    set_ships 2 # AI
    play
  end

  def set_ships(player)
    # TODO: sanitizar estos inputs
    if player == 2 # AI
      set_ai_ships
      return
    end
    ship_counter = 0
    @view.print_one_side player
    while ship_counter < @model.n_ships
      ship_size = 3 # Podria ser al azar en vola
      puts "\nSet a ship of size #{ship_size}"
      orientation = request_orientation()
			row = request_row(@model.size)
			col = request_column(@model.size)
      ship = Ship.new(ship_size, row, col, orientation == 1)
      @model.add_ship player, ship # TODO: revisar que sea valido pornerlo ahi
      @p1_ships << ship
      ship_counter += 1
      @view.print_one_side player
    end
  end

  def set_ai_ships
    ship_counter = 0
    while ship_counter < @model.n_ships
      puts 'AI is setting its Ships'
      ship_size = 3 # Podria ser al azar en vola
      orientation = rand(2)
      row = rand(@model.size)
      col = rand(@model.size)
      ship = Ship.new(ship_size, row, col, orientation == 1)
      @model.add_ship 1, ship # TODO: revisar que sea valido pornerlo ahi
      @p2_ships << ship
      ship_counter += 1
    end
  end

  def play
    until win?
      play_turn @turn
      @turn = @turn.zero? ? 2 : 0
    end
    finish_game
  end

  def play_turn(player)
    if player == 2
      play_ai_turn
      return
    end
    @view.show_board_for player
    puts 'Choose your shot'
		row = request_row(@model.size)
		col = request_column(@model.size)
    hit, sunk_ship = handle_shot_from player, row, col # TODO: filtrar shots repetidos e invalidos
    @model.shot_from player, row, col
    @model.update_sink_by player, sunk_ship if sunk_ship
    @view.show_board_for player
    if hit
      puts "It's a hit!"
      puts 'You sunk a rival ship!' if sunk_ship
      return if win?

      puts 'You can shoot again'
      play_turn player
    else
      puts "It's a miss"
    end
  end

  def play_ai_turn
    puts 'Press enter for AI to play'
    $stdin.gets
    row = rand(1..@model.size)
    col = rand(1..@model.size)
    hit, sunk_ship = handle_shot_from 1, row, col # TODO: filtrar shots repetidos e invalidos
    @model.shot_from 1, row, col
    @model.update_sink_by 1, sunk_ship if sunk_ship
    @view.show_board_for 0
    if hit
      puts "It's a hit from the AI!"
      puts 'The AI sunk one of your ships!' if sunk_ship
      return if win?

      puts 'The AI can shoot again'
      play_turn 2
    else
      puts "It's a miss"
    end
  end

  def handle_shot_from(player, row, col)
    # returns (hit, sunk_ship)
    ships_to_check = player.zero? ? @p2_ships : @p1_ships
    ships_to_check.each do |ship|
      next unless ship.is_in? row, col

      ship.receive_hit_in row, col
      return true, ship if ship.sunk

      return true, nil
    end
    [false, nil]
  end

  # def get_row_col
  #   puts 'Select a row: '
  #   r = $stdin.gets.to_s.chomp.upcase
  #   row = @row_to_int[r]
  #   puts 'Select a column: '
  #   col = $stdin.gets.to_i
  #   [row, col]
  # end

  def win?
    # returns true si alguien ya hundio todos los barcos del otro y setea winner
    @winner = 1
    @p1_ships.each do |ship|
      @winner = 0 unless ship.sunk
    end
    return true if @winner == 1

    @p2_ships.each do |ship|
      @winner = -1 unless ship.sunk
    end
    return true if @winner.zero?

    false
  end

  def finish_game
    winner_name = @winner.zero? ? 'Player 1' : 'Player 2'
    puts "Game over! The winner is #{winner_name}"
  end
end
