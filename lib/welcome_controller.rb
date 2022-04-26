# frozen_string_literal: true

require_relative './base_controller'

# Clase que comienza el juego y setea la dificultad y el modo
class WelcomeController < BaseController
  def initialize(difficulty)
    super()
    @difficulty = difficulty
  end

  def welcome
    # Retorna el modo (1p or 2p) y la dificultad
    mode = 0
    puts "\n WELCOME TO BATTLESHIP! 🚢 🧨 \n\n"
    while (mode != 1) && (mode != 2)
      puts " 1) 👥 Play against other player \n 2) 🤖 Play against AI\n"
      mode = stdin_get_integer 1
    end
    diff = 0
    while (diff != 1) && (diff != 2)
      puts "\n SELECT A DIFFICULTY \n 1) 🚼 Easy \n 2) 🔥 Hard"
      diff = stdin_get_integer 2
    end
    [mode, @difficulty[diff][0], @difficulty[diff][1]]
  end
end
