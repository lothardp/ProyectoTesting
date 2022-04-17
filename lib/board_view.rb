require_relative './observable/observer'

class BoardView < Observer
    def update(board_model)
        show(board_model)
    end

    def show(board_model)
        # printea los tableros
    end
end