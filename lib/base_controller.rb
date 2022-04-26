# frozen_string_literal: true

# Clase que modela funciones basicas para poder testear
class BaseController
  # funcion que envuelve IO para hacer un stub. recibe una variable
  # para poder mapear el output. por ejemplo, si se busca que en mode
  # retorne 1 y en diff retorne 3, se hace un hash {1: 1, 2: 3}.
  # :nocov:
  def stdin_get_integer(_var)
    $stdin.gets.to_i
  end
  # :nocov:

  # funcion que envuelve IO para hacer un stub. recibe una variable
  # para poder mapear el output. Similar a stdin_get_integer, solo
  # que retorna un string.
  # :nocov:
  def stdin_get_string(_var)
    $stdin.gets.to_s.chomp.upcase
  end
  # :nocov:

  # funcion que retorna un numero aleatorio. La idea es poder hacer un
  # stub que elimine la aleatoriedad
  # :nocov:
  def get_rand(range, _var)
    rand(range)
  end
  # :nocov:

  # funcion que imprime en pantalla. Sirve para silenciar los prints
  # en testing.
  # :nocov:
  def print(val)
    puts val
  end
  # :nocov:
end
