# frozen_string_literal: true

class WellcomeController
  def initialize(difficulty)
    @difficulty = difficulty
  end

  def welcome
    # Retorna el modo (1p or 2p) y la dificultad
    mode = 0
    while (mode != 1) && (mode != 2)
      puts "1) Play against other player \n2) Play against AI"
      mode = $stdin.gets.to_i
    end
    diff = 0
    while (diff != 1) && (diff != 2)
      puts "Select a difficulty \n1) easy \n2) hard"
      diff = $stdin.gets.to_i
    end
    [mode, @difficulty[diff][0], @difficulty[diff][1]]
  end
end
