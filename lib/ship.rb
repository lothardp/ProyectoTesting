# frozen_string_literal: true

class Ship
  attr_accessor :size, :is_vertical, :bow, :stern

  def initialize(size, row, col, is_vertical)
    @size = size
    @is_vertical = is_vertical
    @bow = { 'row' => row, 'col' => col } # proa -> parte delantera
    @stern = if is_vertical
               { 'row' => (row + size - 1),
                 'col' => col }
             else
               { 'row' => row, 'col' => (col + size - 1) }
             end
  end

  def positions
    pos = []
    (0..(@size - 1)).each do |i|
      if @is_vertical
        pos.push([@bow['row'] + i, @bow['col']])
      else
        pos.push([@bow['row'], @bow['col'] + i])
      end
    end
    pos
  end
end
