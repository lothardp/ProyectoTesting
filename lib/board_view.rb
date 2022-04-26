# frozen_string_literal: true

require 'io/console'

# :nocov:
# Clase que modela la vista del juego, se comunica con la terminal (input/output)
class BoardView
  attr_accessor :letters

  def initialize(model)
    @model = model
    @letters = %w[A B C D E F G H I J K L]
  end

  def ask_for_orientation
    print "Select orientation\n 1) vertical\n 2) horizonal"
    $stdin.gets.to_i
  end

  def ask_for_row
    print 'Select a row: '
    $stdin.gets.to_s.chomp.upcase
  end

  def ask_for_column
    print 'Select a column: '
    $stdin.gets.to_i
  end

  def show_set_ship_of_size(ship_size)
    print "\nSet a ship of size #{ship_size}"
  end

  def show_invalid_ship_position
    print 'Invalid position, try another'
  end

  def show_ai_setting_ships
    print 'AI is setting its Ships'
  end

  def show_invalid_shot
    print 'Invalid shot, already hit that box'
  end

  def show_choose_your_shot
    print 'Choose your shot'
  end

  def show_hit
    print "It's a hit!"
  end

  def show_sink
    print 'You sunk a rival ship!'
  end

  def show_shoot_again
    print 'You can shoot again'
  end

  def show_miss
    print "It's a miss"
  end

  def ask_for_press_for_ai_play
    print 'Press enter for AI to play'
    $stdin.gets
  end

  def show_ai_hit
    print "It's a hit from the AI!"
  end

  def show_ai_sink
    print 'The AI sunk one of your ships!'
  end

  def show_ai_shoot_again
    print 'The AI can shoot again'
  end

  def show_game_over(winner_name)
    print "Game over! The winner is #{winner_name}"
  end

  def print_one_side(player)
    # $stdout.clear_screen
    board_to_print = player.zero? ? @model.board1 : @model.board2
    player_name = player.zero? ? 'Player 1' : 'Player 2'
    puts "#{player_name}'s board: "
    print_board board_to_print, false
  end

  def show_board_for(player)
    # $stdout.clear_screen
    player_board = player.zero? ? @model.board1 : @model.board2
    rival_board = player.zero? ? @model.board2 : @model.board1
    puts '   Oponent board'
    print_board rival_board, true
    puts '   Your board'
    print_board player_board, false
  end

  def print_board(board, hide_ships = false) # rubocop:disable Style/OptionalBooleanParameter
    len = board.length
    print '   '
    (1..len).each do |number|
      print "#{number} "
    end
    print "\n"
    (1..len).each do |row|
      print "#{@letters[row - 1]} |"
      (1..len).each do |col|
        symbol = board[row][col]
        symbol = ' ' if hide_ships && symbol == 'S'
        print "#{symbol}|"
      end
      print "\n"
    end
    $stdout.flush
  end
end
# :nocov:
