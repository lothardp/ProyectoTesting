
class Controller
    def initialize(difficulty)
        @difficulty = difficulty
    end

    def welcome
        # listo para testear
        mode = 0
        while mode != 1 and mode != 2 do
            puts "1) Play against other player \n2) Play against AI"
            mode = $stdin.gets.to_i
        end
        diff = 0
        while diff != 1 and diff != 2
            puts "Select a difficulty \n1) easy \n2) hard"
            diff = $stdin.gets.to_i
        end
        return mode, @difficulty[diff]
    end
end