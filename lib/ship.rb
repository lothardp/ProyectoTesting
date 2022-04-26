# frozen_string_literal: true

# Clase que modela un barco
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
    neighbors = @is_vertical ? vertical_neighbors : horizontal_neighbors
    clean_neighbors neighbors, board_size
  end

  def vertical_neighbors # rubocop:disable Metrics
    neighbors = []
    (-1..@size).each do |i|
      neighbors << [@bow['row'] + i, @bow['col'] - 1]
      neighbors << [@bow['row'] + i, @bow['col'] + 1]
    end
    neighbors << [@bow['row'] - 1, @bow['col']]
    neighbors << [@bow['row'] + @size, @bow['col']]
    neighbors
  end

  def horizontal_neighbors # rubocop:disable Metrics
    neighbors = []
    (-1..@size).each do |i|
      neighbors << [@bow['row'] - 1, @bow['col'] + i]
      neighbors << [@bow['row'] + 1, @bow['col'] + i]
    end
    neighbors << [@bow['row'], @bow['col'] - 1]
    neighbors << [@bow['row'], @bow['col'] + @size]
    neighbors
  end

  def clean_neighbors(neighbors, board_size)
    new_neighbors = []
    neighbors.each do |row, col|
      new_neighbors.push([row, col]) if row.positive? && row <= board_size && col.positive? && col <= board_size
    end
    new_neighbors
  end
end
