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
    @turn = 0
    play
  end

  def set_ships(player)
    # TODO: sanitizar estos inputs
    if player == 2 # AI
      set_ai_ships
      return
    end
    ship_counter = 0
    while ship_counter < @model.n_ships
      @view.print_one_side player
      ship_size = 3 # Podria ser al azar en vola
      puts "\nSet a ship of size #{ship_size}"
      puts "Select orientation\n 1) vertical\n 2) horizonal"
      orientation = $stdin.gets.to_i
      row, col = get_row_col
      ship = Ship.new(ship_size, row, col, orientation == 1)
      @model.add_ship player ship # TODO: revisar que sea valido pornerlo ahi
      @p1_ships << ship
      ship_counter += 1
    end
  end

  def set_ai_ships
    ship_counter = 0
    while ship_counter < @model.n_ships
      puts 'AI is setting its Ships'
      ship_size = 3 # Podria ser al azar en vola
      orientation = rand(2)
      r = $stdin.gets.to_s.upcase
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
      play_turn turn
      turn = turn.zero? ? 1 : 0
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
    row, col = get_row_col
    hit, sunk_ship = handle_shot_from player, row, col # TODO: filtrar shots repetidos e invalidos
    @model.shot_from player, row, col
    @view.show_board_for player
    if hit
      puts "It's a hit!"
      if sunk_ship
        puts 'You sunk a rival ship!'
        @model.update_sink sunk_ship
      end
      return if win?

      puts 'You can shoot again'
      play_turn player
    end
  end

  def handle_shot_from(player, row, col)
    # returns (hit, sunk_ship)
    ships_to_check = player.zero? ? @p2_ships : @p1_ships
    ships_to_check.each do |ship|
      next unless ship.is_in? row, col
      ship.hit_in row, col
      return true, ship if ship.sunk?
      return true, nil
    end
  end

  def get_row_col
    puts 'Select a row: '
    r = $stdin.gets.to_s.upcase
    row = @row_to_int[r]
    puts 'Select a column: '
    col = $stdin.gets.to_i
    [row, col]
  end
end
