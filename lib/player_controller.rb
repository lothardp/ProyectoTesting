# frozen_string_literal: true

require_relative './ship'

class PlayerController
  def initialize
    @p1_ships = []
    @p2_ships = []
    @row_to_int = { 'A' => 1, 'B' => 2, 'C' => 3, 'D' => 4, 'E' => 5, 'F' => 6,
                    'G' => 7, 'H' => 8, 'I' => 9, 'J' => 10, 'K' => 11, 'L' => 12 }
  end

  def request_orientation
    orientation = 0
    while orientation != 1 && orientation != 2
        puts "Select orientation\n 1) vertical\n 2) horizonal"
        orientation = $stdin.gets.to_i
    end
    return orientation
	end

	def request_row(board_size)
		row = 0
		while (row < 1 or row > board_size)
				puts "Select a row: "
				r = $stdin.gets.to_s.chomp.upcase
				@row_to_int[r] == nil ? next : row = @row_to_int[r]
		end
		return row
	end

	def request_column(board_size)
		col = 0
		while col < 1 || col > board_size
				puts "Select a column: "
				col = $stdin.gets.to_i
		end
		return col
	end
end
