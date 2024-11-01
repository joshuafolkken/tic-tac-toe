# gdlint: disable=unused-argument
# GdUnit generated TestSuite
class_name BoardPositionTest
extends GdUnitTestSuite

@warning_ignore("unused_parameter")


func test_init(
	row_index: int,
	col_index: int,
	is_success: bool,
	test_parameters := [
		[0, 0, true],
		[-1, -1, true],
		[-2, -2, false],
		[1, 2, true],
		[1, 3, false],
		[2, 0, true],
		[3, 2, false],
	]
) -> void:
	match is_success:
		true:
			await (
				assert_error(func() -> void: BoardPosition.get_instance(row_index, col_index))
				. is_success()
			)
		false:
			await (
				assert_error(func() -> void: BoardPosition.get_instance(row_index, col_index))
				. is_push_error(
					"Invalid position: row_index=%d, col_index=%d" % [row_index, col_index]
				)
			)


@warning_ignore("unused_parameter")


func test_hash(
	row_index: int,
	col_index: int,
	expected: int,
	test_parameters := [
		[0, 0, 0],
		[-1, -1, -4],
		[1, 2, 5],
	]
) -> void:
	var board_position := BoardPosition.get_instance(row_index, col_index)
	var actual := board_position.hash()
	assert_int(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_to_string(
	row_index: int,
	col_index: int,
	expected: String,
	test_parameters := [
		[-1, -1, "BoardPosition(row = -1, col = -1)"],
		[2, 1, "BoardPosition(row = 2, col = 1)"],
	]
) -> void:
	var board_position := BoardPosition.get_instance(row_index, col_index)
	var actual := board_position.to_string()
	assert_str(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_to_index(
	row_index: int,
	col_index: int,
	expected: int,
	test_parameters := [
		[-1, -1, -4],
		[2, 1, 7],
	],
) -> void:
	var board_position := BoardPosition.get_instance(row_index, col_index)
	var actual := board_position.to_index()
	assert_int(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_is_valid(
	row_index: int,
	col_index: int,
	expected: bool,
	test_parameters := [
		[-1, -1, false],
		[-1, 0, false],
		[0, -1, false],
		[0, 0, true],
		[1, 2, true],
		[2, 2, true],
	],
) -> void:
	var board_position := BoardPosition.get_instance(row_index, col_index)
	var actual := board_position.is_valid()
	assert_bool(actual).is_equal(expected)
