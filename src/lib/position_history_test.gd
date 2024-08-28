# gdlint: disable=unused-argument
# GdUnit generated TestSuite
class_name PositionHistoryTest
extends GdUnitTestSuite


@warning_ignore("unused_parameter")


func test_append(
	board_positions: Array,
	expecteds: Array,
	test_parameters := [
		[
			[BoardPosition.new(1, 2)],
			[BoardPosition.invalid, BoardPosition.invalid],
		],
		[
			[
				BoardPosition.new(1, 2),
				BoardPosition.new(2, 0),
				BoardPosition.new(0, 1),
				BoardPosition.new(0, 0),
				BoardPosition.new(2, 0),
				BoardPosition.new(2, 0)
			],
			[BoardPosition.invalid, BoardPosition.new(1, 2)],
		],
		[
			[
				BoardPosition.new(1, 2),
				BoardPosition.new(2, 0),
				BoardPosition.new(0, 1),
				BoardPosition.new(0, 0),
				BoardPosition.new(2, 0),
				BoardPosition.new(2, 0),
				BoardPosition.new(1, 2)
			],
			[BoardPosition.new(1, 2), BoardPosition.new(2, 0)],
		],
		[
			[
				BoardPosition.new(1, 2),
				BoardPosition.new(2, 0),
				BoardPosition.new(0, 1),
				BoardPosition.new(0, 0),
				BoardPosition.new(2, 0),
				BoardPosition.new(2, 0),
				BoardPosition.new(1, 2),
				BoardPosition.new(2, 2)
			],
			[BoardPosition.new(2, 0), BoardPosition.new(0, 1)],
		],
	]
) -> void:
	var position_history := PositionHistory.new()
	var actuals: Array[BoardPosition] = []

	for board_position: BoardPosition in board_positions:
		actuals = position_history.append(board_position)

	for i in range(actuals.size()):
		var actual: BoardPosition = actuals[i]
		var expected: BoardPosition = expecteds[i]

		assert_bool(actual.is_equal(expected)).is_true()
