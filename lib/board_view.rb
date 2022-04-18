require_relative './observable/observer'

class BoardView < Observer
    attr_accessor :letters
    
    def initialize
        super()
        @letters = ["A", "B", "C", "D", "E", "F", "G", "H"]
    end
    def update(board_model)
        printBoard(board_model)
    end

    def printBoard(board_model)
        print "   "
        for number in 1..board_model.size
            print "#{number} "
        end
        print "\n"
        for row in 1..board_model.size
          print "#{@letters[row - 1]} |"
          for col in 1..board_model.size
            print "#{board_model.positions[row][col]}|"
          end
          print "\n"
        end
        STDOUT.flush
    end
end