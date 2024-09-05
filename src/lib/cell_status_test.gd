# gdlint: disable=unused-argument
# GdUnit generated TestSuite
class_name CellStatusTest
extends GdUnitTestSuite

@warning_ignore("unused_parameter")


func test_init(
	state: CellStatus.State,
	is_success: bool,
	test_parameters := [
		[CellStatus.State.EMPTY, true],
		[CellStatus.State.X, true],
		[CellStatus.State.O, true],
		[-1, false],
	]
) -> void:
	match is_success:
		true:
			await assert_error(func() -> void: CellStatus.new(state)).is_success()
		false:
			await assert_error(func() -> void: CellStatus.new(state)).is_push_error(
				"Invalid state: -1"
			)


@warning_ignore("unused_parameter")


func test_to_string(
	state: CellStatus.State,
	expected: String,
	test_parameters := [
		[CellStatus.State.EMPTY, "EMPTY"],
		[CellStatus.State.X, "X"],
		[CellStatus.State.O, "O"],
	]
) -> void:
	var cell_status := CellStatus.new(state)
	var actual := cell_status.to_string()
	assert_str(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_is_empty(
	state: CellStatus.State,
	expected: bool,
	test_parameters := [
		[CellStatus.State.EMPTY, true],
		[CellStatus.State.X, false],
		[CellStatus.State.O, false],
	]
) -> void:
	var cell_status := CellStatus.new(state)
	var actual := cell_status.is_empty()
	assert_bool(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_is_not_empty(
	state: CellStatus.State,
	expected: bool,
	test_parameters := [
		[CellStatus.State.EMPTY, false],
		[CellStatus.State.X, true],
		[CellStatus.State.O, true],
	]
) -> void:
	var cell_status := CellStatus.new(state)
	var actual := cell_status.is_not_empty()
	assert_bool(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_is_x(
	state: CellStatus.State,
	expected: bool,
	test_parameters := [
		[CellStatus.State.EMPTY, false],
		[CellStatus.State.X, true],
		[CellStatus.State.O, false],
	]
) -> void:
	var cell_status := CellStatus.new(state)
	var actual := cell_status.is_x()
	assert_bool(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_is_o(
	state: CellStatus.State,
	expected: bool,
	test_parameters := [
		[CellStatus.State.EMPTY, false],
		[CellStatus.State.X, false],
		[CellStatus.State.O, true],
	]
) -> void:
	var cell_status := CellStatus.new(state)
	var actual := cell_status.is_o()
	assert_bool(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_is_equal(
	left_state: CellStatus.State,
	right_state: CellStatus.State,
	expected: bool,
	test_parameters := [
		[CellStatus.State.EMPTY, CellStatus.State.EMPTY, true],
		[CellStatus.State.X, CellStatus.State.X, true],
		[CellStatus.State.O, CellStatus.State.O, true],
		[CellStatus.State.EMPTY, CellStatus.State.X, false],
		[CellStatus.State.X, CellStatus.State.O, false],
		[CellStatus.State.O, CellStatus.State.EMPTY, false],
	]
) -> void:
	var left_cell_status := CellStatus.new(left_state)
	var right_cell_status := CellStatus.new(right_state)
	var actual := left_cell_status.is_equal(right_cell_status)

	assert_bool(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_is_equal_and_not_empty(
	left_state: CellStatus.State,
	right_state: CellStatus.State,
	expected: bool,
	test_parameters := [
		[CellStatus.State.EMPTY, CellStatus.State.EMPTY, false],
		[CellStatus.State.X, CellStatus.State.X, true],
		[CellStatus.State.O, CellStatus.State.O, true],
		[CellStatus.State.EMPTY, CellStatus.State.X, false],
		[CellStatus.State.X, CellStatus.State.O, false],
		[CellStatus.State.O, CellStatus.State.EMPTY, false],
	]
) -> void:
	var left_cell_status := CellStatus.new(left_state)
	var right_cell_status := CellStatus.new(right_state)
	var actual := left_cell_status.is_equal_and_not_empty(right_cell_status)

	assert_bool(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_from_game_player(
	game_player_id: GamePlayer.Id,
	is_success: bool,
	expected: CellStatus.State,
	test_parameters := [
		[GamePlayer.Id.X, true, CellStatus.State.X],
		[GamePlayer.Id.O, true, CellStatus.State.O],
	]
) -> void:
	var game_player := GamePlayer.new(game_player_id)

	print(is_success)

	match is_success:
		true:
			await (
				assert_error(func() -> void: CellStatus.from_game_player(game_player)).is_success()
			)

			var cell_status := CellStatus.from_game_player(game_player)
			assert_int(cell_status.get_value()).is_equal(expected)

		false:
			await (
				assert_error(func() -> void: CellStatus.from_game_player(game_player))
				. is_push_error("Invalid game player: %s" % game_player)
			)
