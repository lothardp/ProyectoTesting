require_relative './observable/observable'


class Board < Observable
    attr_accessor :size, :positions
    
    def initialize(size)
        super()
        @size = size
        @positions = Hash.new
        build_board()
    end

    def build_board()
        for row in 1..@size
            @positions[row] = Hash.new
            for col in 1..@size
                @positions[row][col] = " "
            end
        end
        change_board()
    end

    def change_board()
        @positions[1][8] = "X"
        @positions[4][2] = "X"
        @positions[6][6] = "-"
        @positions[3][4] = "-"
        add_ship(3, 2, 4)
    end

    def out_of_bounds?(ship)
        return (
            ship.bow[row] < 1 || ship.bow[row] > @size ||
            ship.bow[col] < 1 || ship.bow[col] > @size ||
            ship.stern[row] > @size || ship.stern[col] > @size
        )
    end

    def ship_collision(ship)
        ship.positions.each do |row, col| # [[1,2], [1,3], [1,4]]
            if @positions[row][col] == 'S'
                return true
            end
        end
        return false
    end

    # unless invalid_position(ship)
    #   add_ship(ship)
    # end

    def invalid_position(ship)
        if out_of_bounds?(ship) return false
        if ship_collision?(ship) return false
        return true
    end

    def add_ship(ship)
        ship.positions.each do { |row, col| @positions[row][col] = "S" }
    end
end