# gdlint: disable=class-definitions-order
extends GutTest

var _game_player: GamePlayer


func before_each():
	gut.p("before_each")
	_game_player = GamePlayer.new()


func after_each():
	gut.p("after_each")


func before_all():
	gut.p("before_all")


func after_all():
	gut.p("after_all")


func test_assert_equal():
	assert_eq(1, 1, "1 should be equal to 1")


func test_assert_true():
	assert_true(true, "true should be true")


var test_cases = (
	ParameterFactory
	. named_parameters(
		["actual", "to_string", "get_value", "is_x", "is_o", "next"],
		[
			[GamePlayer.Id.X, "GamePlayer(id=0)", 0, true, false, GamePlayer.Id.O],
			[GamePlayer.Id.O, "GamePlayer(id=1)", 1, false, true, GamePlayer.Id.X],
		]
	)
)


func test_to_string(params = use_parameters(test_cases)):
	var actual = GamePlayer.new(params.actual)
	assert_eq(actual.to_string(), params.to_string)


func test_get_value(params = use_parameters(test_cases)):
	var actual = GamePlayer.new(params.actual)
	assert_eq(actual.get_value(), params.get_value)


func test_is_x(params = use_parameters(test_cases)):
	var actual = GamePlayer.new(params.actual)
	assert_eq(actual.is_x(), params.is_x)


func test_is_o(params = use_parameters(test_cases)):
	var actual = GamePlayer.new(params.actual)
	assert_eq(actual.is_o(), params.is_o)


func test_next(params = use_parameters(test_cases)):
	var actual = GamePlayer.new(params.actual)
	assert_eq(actual.next().get_value(), params.next)
