# frozen_string_literal: true

# código tomado del ejemplo de tres-en-línea

class Observer
  def update(board)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
