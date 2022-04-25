# frozen_string_literal: true

class Ship
  attr_accessor :size, :is_vertical, :positions, :sunk, :neighbors

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
    @hits << [row, col] if in? row, col
    @sunk = true
    @positions.each do |p|
      @sunk = false unless @hits.include? p
    end
  end

  def in?(row, col)
    if @positions.include? [row, col]
      true
    else
      false
    end
  end

  def get_neighbors(board_size)
    if @is_vertical
      neighbors = vertical_neighbors
    else
      neighbors = horizontal_neighbors
    end
    new_neighbors = clean_neighbors(neighbors, board_size)
    new_neighbors
  end

  def vertical_neighbors
    neighbors = []
    (-1..@size).each do |i|
      neighbors.push([@bow['row'] + i, @bow['col'] - 1])
      neighbors.push([@bow['row'] + i, @bow['col'] + 1])
    end
    neighbors.push([@bow['row'] - 1, @bow['col']])
    neighbors.push([@bow['row'] + @size, @bow['col']])
    neighbors
  end

  def horizontal_neighbors
    neighbors = []
    (-1..@size).each do |i|
      neighbors.push([@bow['row'] - 1, @bow['col'] + i])
      neighbors.push([@bow['row'] + 1, @bow['col'] + i])
    end
    neighbors.push([@bow['row'], @bow['col'] - 1])
    neighbors.push([@bow['row'], @bow['col'] + @size])
    neighbors
  end

  def clean_neighbors(neighbors, board_size)
    new_neighbors = []
    neighbors.each do |row, col|
      if row > 0 && row <= board_size && col > 0 && col <= board_size
        new_neighbors.push([row, col]) 
      end
    end
    new_neighbors
  end
end
