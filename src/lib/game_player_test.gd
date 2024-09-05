# gdlint: disable=unused-argument
# GdUnit generated TestSuite
class_name GamePlayerTest
extends GdUnitTestSuite

@warning_ignore("unused_parameter")


func test_init() -> void:
	await assert_error(func() -> void: GamePlayer.new()).is_success()


@warning_ignore("unused_parameter")


func test_to_string(
	id: GamePlayer.Id,
	expected: String,
	test_parameters := [
		[GamePlayer.Id.X, "GamePlayer(id = X)"], [GamePlayer.Id.O, "GamePlayer(id = O)"]
	]
) -> void:
	var game_player := GamePlayer.new(id)
	var actual := game_player.to_string()
	assert_str(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_get_value(
	id: GamePlayer.Id,
	expected: GamePlayer.Id,
	test_parameters := [
		[null, GamePlayer.Id.X],
		[GamePlayer.Id.X, GamePlayer.Id.X],
		[GamePlayer.Id.O, GamePlayer.Id.O],
	]
) -> void:
	var game_player := GamePlayer.new(id)
	var actual := game_player.get_value()
	assert_int(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_is_x(
	id: GamePlayer.Id,
	expected: bool,
	test_parameters := [[GamePlayer.Id.X, true], [GamePlayer.Id.O, false]]
) -> void:
	var game_player := GamePlayer.new(id)
	var actual := game_player.is_x()
	assert_bool(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_is_o(
	id: GamePlayer.Id,
	expected: bool,
	test_parameters := [[GamePlayer.Id.X, false], [GamePlayer.Id.O, true]]
) -> void:
	var game_player := GamePlayer.new(id)
	var actual := game_player.is_o()
	assert_bool(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_next(
	id: GamePlayer.Id,
	expected: GamePlayer.Id,
	test_parameters := [
		[GamePlayer.Id.X, GamePlayer.Id.O],
		[GamePlayer.Id.O, GamePlayer.Id.X],
	]
) -> void:
	var game_player := GamePlayer.new(id)
	var next_game_player := game_player.next()
	var actual := next_game_player.get_value()
	assert_int(actual).is_equal(expected)
