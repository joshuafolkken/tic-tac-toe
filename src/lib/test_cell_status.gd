## gdlint: disable=class-definitions-order
extends GutTest


func before_each() -> void:
	pass


class TestCase:
	var actual: CellStatus
	var expected_string: String
	var get_value: CellStatus.State
	var is_empty: bool
	var is_not_empty: bool
	var is_x: bool
	var is_o: bool

	@warning_ignore("shadowed_variable")

	func _init(
		actual: CellStatus,
		expected_string: String,
		get_value: CellStatus.State,
		is_empty: bool,
		is_not_empty: bool,
		is_x: bool,
		is_o: bool
	) -> void:
		self.actual = actual
		self.expected_string = expected_string
		self.get_value = get_value
		self.is_empty = is_empty
		self.is_not_empty = is_not_empty
		self.is_x = is_x
		self.is_o = is_o


static var test_cases: Array[TestCase] = [
	TestCase.new(CellStatus.empty, "EMPTY", CellStatus.State.EMPTY, true, false, false, false),
	TestCase.new(CellStatus.x, "X", CellStatus.State.X, false, true, true, false),
	TestCase.new(CellStatus.o, "O", CellStatus.State.O, false, true, false, true),
]


func test_properties(test_case: TestCase = use_parameters(test_cases)) -> void:
	assert_eq(test_case.actual.to_string(), test_case.expected_string)
	assert_eq(test_case.actual.get_value(), test_case.get_value)
	assert_eq(test_case.actual.is_empty(), test_case.is_empty)
	assert_eq(test_case.actual.is_not_empty(), test_case.is_not_empty)
	assert_eq(test_case.actual.is_x(), test_case.is_x)
	assert_eq(test_case.actual.is_o(), test_case.is_o)


func test_is_equal() -> void:
	var empty := CellStatus.new(CellStatus.State.EMPTY)
	var x := CellStatus.new(CellStatus.State.X)
	var o := CellStatus.new(CellStatus.State.O)

	assert_true(CellStatus.empty.is_equal(empty))
	assert_true(CellStatus.x.is_equal(x))
	assert_true(CellStatus.o.is_equal(o))

	assert_false(CellStatus.empty.is_equal(x))
	assert_false(CellStatus.empty.is_equal(o))
	assert_false(CellStatus.x.is_equal(o))


func test_is_equal_and_not_empty() -> void:
	var empty := CellStatus.new(CellStatus.State.EMPTY)
	var x := CellStatus.new(CellStatus.State.X)
	var o := CellStatus.new(CellStatus.State.O)

	assert_false(CellStatus.empty.is_equal_and_not_empty(empty))
	assert_true(CellStatus.x.is_equal_and_not_empty(x))
	assert_true(CellStatus.o.is_equal_and_not_empty(o))

	assert_false(CellStatus.empty.is_equal_and_not_empty(x))
	assert_false(CellStatus.empty.is_equal_and_not_empty(o))
	assert_false(CellStatus.x.is_equal_and_not_empty(o))


class FromGamePlayerTestCase:
	var actual: GamePlayer
	var expected: CellStatus

	@warning_ignore("shadowed_variable")

	func _init(actual: GamePlayer, expected: CellStatus) -> void:
		self.actual = actual
		self.expected = expected


static var from_game_player_test_cases: Array[FromGamePlayerTestCase] = [
	FromGamePlayerTestCase.new(GamePlayer.new(GamePlayer.Id.X), CellStatus.x),
	FromGamePlayerTestCase.new(GamePlayer.new(GamePlayer.Id.O), CellStatus.o),
]


func test_from_game_player(
	test_case: FromGamePlayerTestCase = use_parameters(from_game_player_test_cases)
) -> void:
	assert_eq(CellStatus.from_game_player(test_case.actual), test_case.expected)
