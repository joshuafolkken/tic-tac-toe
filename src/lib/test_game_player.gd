# gdlint: disable=class-definitions-order
extends GutTest


func before_each() -> void:
	pass


class TestCase:
	var actual: GamePlayer
	var expected_string: String
	var get_value: GamePlayer.Id
	var is_x: bool
	var is_o: bool
	var next: GamePlayer

	@warning_ignore("shadowed_variable")

	func _init(
		actual: GamePlayer,
		expected_string: String,
		get_value: GamePlayer.Id,
		is_x: bool,
		is_o: bool,
		next: GamePlayer
	) -> void:
		self.actual = actual
		self.expected_string = expected_string
		self.get_value = get_value
		self.is_x = is_x
		self.is_o = is_o
		self.next = next


static var test_cases: Array[TestCase] = [
	TestCase.new(
		GamePlayer.new(GamePlayer.Id.X),
		"GamePlayer(id=0)",
		GamePlayer.Id.X,
		true,
		false,
		GamePlayer.new(GamePlayer.Id.O)
	),
	TestCase.new(
		GamePlayer.new(GamePlayer.Id.O),
		"GamePlayer(id=1)",
		GamePlayer.Id.O,
		false,
		true,
		GamePlayer.new(GamePlayer.Id.X)
	),
]


func test_properties(test_case: TestCase = use_parameters(test_cases)) -> void:
	assert_eq(test_case.actual.to_string(), test_case.expected_string)
	assert_eq(test_case.actual.get_value(), test_case.get_value)
	assert_eq(test_case.actual.is_x(), test_case.is_x)
	assert_eq(test_case.actual.is_o(), test_case.is_o)
	assert_eq(test_case.actual.next().get_value(), test_case.next.get_value())
