require_relative './player_controller'

class OnePlayerController < PlayerController
    def initialize(board_model_p1, board_view, board_model_p2)
        super()
        @model_p1 = board_model_p1
        @view_p1 = board_view
        @model_p2 = board_model_p2
    end

    def request_ships(n_ships)
        # falta sanitizar estos inputs
        @view_p1.update(@model_p1)
        ship_counter = 0
        while ship_counter < n_ships
            ship_size = rand(1..(@model_p1.size/2))
            puts "\nSet a ship of size #{ship_size}"
            puts "Select orientation\n 1) vertical\n 2) horizonal"
            orientation = $stdin.gets.to_i
            puts "Select a row: "
            r = $stdin.gets.to_s.upcase
            row = @row_map[r]
            puts "Select a column: "
            col = $stdin.gets.to_i
            ship = Ship.new(ship_size, row, col, orientation == 1)
            if @model_p1.invalid_position(ship)
                next
            else
                @model_p1.add_ship(ship)
                @p1_ships << ship
                ship_counter += 1
            end
        end
    end

    
end