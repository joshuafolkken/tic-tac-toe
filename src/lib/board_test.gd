# gdlint: disable=unused-argument
# GdUnit generated TestSuite
class_name CellStatusTest
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
	cell_status: CellStatus,
	test_parameters := [[0, 1, CellStatus.x], [1, 2, CellStatus.o]]
) -> void:
	var board_position := BoardPosition.new(row_index, col_index)
	var board := Board.new()

	board.set_value(board_position, cell_status)
	var actual := board.get_value(board_position)
	var expected := cell_status

	assert_bool(actual).is_equal(expected)

# func are_all_same_and_not_empty(
# 	cell_statuses: Array[CellStatus],
# )

# func test_vertical_win() -> void:
# 	var board := Board.new()

# 	# 真ん中の列にXを配置
# 	for row in range(BoardPosition.MAX_SIZE):
# 		var position := BoardPosition.new(row, 1)  # 1は真ん中の列
# 		board.set_value(position, CellStatus.new(CellStatus.State.X))

# 	# 勝利条件をチェック
# 	var winner := board.get_winner()
# 	assert_that(winner).is_equal(CellStatus.new(CellStatus.State.X))
