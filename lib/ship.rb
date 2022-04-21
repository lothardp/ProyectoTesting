# frozen_string_literal: true

class Ship
  attr_accessor :size, :is_vertical, :positions, :sunk

  def initialize(size, row, col, is_vertical)
    @size = size
    @is_vertical = is_vertical
    @bow = { 'row' => row, 'col' => col } # proa -> parte delantera
    @positions = set_positions
    @sunk = false
    @hits = []
  end

  def set_positions
    positions = []
    (0..(@size - 1)).each do |i|
      if @is_vertical
        positions.push([@bow['row'] + i, @bow['col']])
      else
        positions.push([@bow['row'], @bow['col'] + i])
      end
    end
    positions
  end

  def receive_hit_in(row, col)
    @hits << [row, col] if is_in? row, col
    @positions.each do |p|
      return unless @hits.include? p
    end
    @sunk = true
  end

  def is_in?(row, col)
    if @positions.include? [row, col]
      true
    else
      false
    end
  end
end
