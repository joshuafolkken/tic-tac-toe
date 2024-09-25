# gdlint: disable=unused-argument
# GdUnit generated TestSuite
class_name GameStatusTest
extends GdUnitTestSuite

@warning_ignore("unused_parameter")


func test_init(
	state: GameStatus.State,
	is_success: bool,
	test_parameters := [
		[GameStatus.State.PLAYING, true],
		[GameStatus.State.X_WIN, true],
		[GameStatus.State.O_WIN, true],
		[GameStatus.State.DRAW, true],
		[-2, false],
	]
) -> void:
	match is_success:
		true:
			await assert_error(func() -> void: GameStatus.new(state)).is_success()
		false:
			await assert_error(func() -> void: GameStatus.new(state)).is_push_error(
				"Invalid state: %s" % str(state)
			)


@warning_ignore("unused_parameter")


func test_is_playing(
	state: GameStatus.State,
	expected: bool,
	test_parameters := [
		[GameStatus.State.PLAYING, true],
		[GameStatus.State.X_WIN, false],
		[GameStatus.State.O_WIN, false],
		[GameStatus.State.DRAW, false],
	]
) -> void:
	var game_status := GameStatus.new(state)
	var actual := game_status.is_playing()
	assert_bool(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_get_result_test(
	state: GameStatus.State,
	expected: String,
	test_parameters := [
		[GameStatus.State.PLAYING, "Playing!?"],
		[GameStatus.State.X_WIN, "X Wins!"],
		[GameStatus.State.O_WIN, "O Wins!"],
		[GameStatus.State.DRAW, "Draw!"],
	]
) -> void:
	var game_status := GameStatus.new(state)
	var actual := game_status.get_result_text()
	assert_str(actual).is_equal(expected)
