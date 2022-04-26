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
    puts "\n SELECT ORIENTATION: \n 1) ⬆️  Vertical\n 2) ⬅️  Horizonal"
    $stdin.gets.to_i
  end

  def ask_for_row
    puts "\n 🔠 SELECT A ROW: "
    $stdin.gets.to_s.chomp.upcase
  end

  def ask_for_column
    puts "\n 🔢 SELECT A COLUMN: "
    $stdin.gets.to_i
  end

  def show_set_ship_of_size(ship_size)
    puts "\n SET A SHIP OF SIZE #{ship_size} 🚢 🆕 \n"
  end

  def show_invalid_ship_position
    puts "\n ❌ Invalid position, try another"
  end

  def show_ai_setting_ships
    puts '\n  🤖 AI is setting its Ships...'
  end

  def show_invalid_shot
    puts "\n ❌ Invalid shot, already hit that box."
  end

  def show_choose_your_shot
    puts "\n 🔫 CHOOSE YOUR SHOOT "
  end

  def show_hit
    puts "\n 💥 IT'S A HIT! 💥 "
  end

  def show_sink
    puts "\n 🎖  YOU SUNK A RIVAL SHIP! 🎖 "
  end

  def show_shoot_again
    puts 'You can shoot again'
  end

  def show_miss
    puts "\n IT'S A MISS 😪"
  end

  def ask_for_press_for_ai_play
    puts "\n 🤖 Press [ENTER] for AI to play"
    $stdin.gets
  end

  def show_ai_hit
    puts "\n 💥 IT'S A HIT from the AI! 💥 "
  end

  def show_ai_sink
    puts "\n 🎖  The AI SUNK ONE OF YOUR SHIPS! 🎖 "
  end

  def show_ai_shoot_again
    puts 'The AI can shoot again'
  end

  def show_game_over(winner_name)
    puts "\n GAME OVER!\n 🎉 The winner is #{winner_name} 🎉 \n "
  end

  def print_one_side(player)
    # $stdout.clear_screen
    board_to_print = player.zero? ? @model.board1 : @model.board2
    player_name = player.zero? ? 'Player 1' : 'Player 2'
    player_icon = player.zero? ? '1️⃣ ' : '2️⃣ '
    puts "\n____________________________ "
    puts "\n #{player_icon} #{player_name}'s board: \n\n"
    print_board board_to_print, false
  end

  def show_board_for(player)
    # $stdout.clear_screen
    player_board = player.zero? ? @model.board1 : @model.board2
    rival_board = player.zero? ? @model.board2 : @model.board1
    puts "\n  🎯 OPONENT BOARD "
    print_board rival_board, true
    puts "\n  👤 YOUR BOARD "
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
