# frozen_string_literal: true

require_relative './observable/observer'

class BoardView < Observer
  attr_accessor :letters

  def initialize
    super()
    @letters = %w[A B C D E F G H I J K L]
  end

  def update(board_model)
    printBoard(board_model)
  end

  def printBoard(board_model)
    print '   '
    (1..board_model.size).each do |number|
      print "#{number} "
    end
    print "\n"
    (1..board_model.size).each do |row|
      print "#{@letters[row - 1]} |"
      (1..board_model.size).each do |col|
        print "#{board_model.positions[row][col]}|"
      end
      print "\n"
    end
    $stdout.flush
  end
end
