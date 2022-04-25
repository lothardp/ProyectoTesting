# frozen_string_literal: true

require_relative 'test_helper'
require_relative 'test_ship'
require_relative '../lib/board_model'
require 'test/unit'
require 'set'

class BoardModelTest < Test::Unit::TestCase
	def setup
		@board = BoardModel.new(8, 3)
	end

  def test_next_to_ship
		@board.board1[1][1] = 'S'
		assert_true(@board.next_to_ship?(3, 1, 2, true, 0))
		assert_false(@board.next_to_ship?(3, 1, 3, true, 0))
  end

	def test_neighbor_boxes
		# on the edge
		neighbors = [[1, 2], [2, 1], [2, 2]]
		boxes = @board.neighbor_boxes(1, 1, 1, true)
		assert_equal(neighbors.to_set, boxes.to_set)

		#on the center vertical
		neighbors = [[1, 2], [1, 3], [1, 4], [2, 2], [2, 4], [3, 2], [3, 3], [3, 4]]
		boxes = @board.neighbor_boxes(1, 2, 3, true)
		assert_equal(neighbors.to_set, boxes.to_set)

		#on the center horizontal
		neighbors = [[1, 2], [1, 3], [1, 4], [2, 2], [2, 4], [3, 2], [3, 3], [3, 4]]
		boxes = @board.neighbor_boxes(1, 2, 3, false)
		assert_equal(neighbors.to_set, boxes.to_set)
	end
end