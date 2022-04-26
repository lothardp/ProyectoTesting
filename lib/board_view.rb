# frozen_string_literal: true

require 'io/console'

class BoardView
  attr_accessor :letters

  def initialize(model)
    @model = model
    @letters = %w[A B C D E F G H I J K L]
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
