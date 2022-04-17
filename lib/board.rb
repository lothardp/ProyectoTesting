require_relative './observable/observable'


class Board < Observable
    def initialize(size)
        @size = size
        @positions = Hash.new(" ")
    end
end