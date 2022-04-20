require_relative './ship'

class PlayerController
    def initialize
        @p1_ships = Array.new
        @p2_ships = Array.new
        @row_map = {"A" => 1, "B" => 2, "C" => 3, "D" => 4, "E" => 5, "F" => 6,
                    "G" => 7, "H" => 8, "I" => 9, "J" => 10, "K" => 11, "L" => 12}
    end
end
