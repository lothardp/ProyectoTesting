# frozen_string_literal: true

class WelcomeController
  def initialize(difficulty)
    @difficulty = difficulty
  end

  def welcome
    # Retorna el modo (1p or 2p) y la dificultad
    mode = 0
    while (mode != 1) && (mode != 2)
      puts "1) Play against other player \n2) Play against AI"
      mode = stdin_get_integer 1
    end
    diff = 0
    while (diff != 1) && (diff != 2)
      puts "Select a difficulty \n1) easy \n2) hard"
      diff = stdin_get_integer 2
    end
    [mode, @difficulty[diff][0], @difficulty[diff][1]]
  end

  # funcion que envuelve IO para hacer un stub. recibe una variable
  # para poder mapear el output. por ejemplo, si se busca que en mode
  # retorne 1 y en diff retorne 3, se hace un hash {1: 1, 2: 3}.
  def stdin_get_integer(var)
    $stdin.gets.to_i
  end
end
