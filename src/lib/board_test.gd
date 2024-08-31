# gdlint: disable=unused-argument
# GdUnit generated TestSuite
class_name BoardTest
extends GdUnitTestSuite

@warning_ignore("unused_parameter")


func test_init() -> void:
	var board := Board.new()

	for row_index in range(BoardPosition.MAX_SIZE):
		for col_index in range(BoardPosition.MAX_SIZE):
			var board_position := BoardPosition.new(row_index, col_index)
			var actual := board.get_value(board_position)
			assert_bool(actual.is_equal(CellStatus.empty)).is_true()


@warning_ignore("unused_parameter")


func test_set_value_and_get_value(
	row_index: int,
	col_index: int,
	expected: CellStatus.State,
	test_parameters := [[0, 1, CellStatus.State.X], [1, 2, CellStatus.State.O]]
) -> void:
	var board_position := BoardPosition.new(row_index, col_index)
	var board := Board.new()

	var cell_status := CellStatus.new(expected)
	board.set_value(board_position, cell_status)
	var actual := board.get_value(board_position).get_value()

	assert_int(actual).is_equal(expected)
