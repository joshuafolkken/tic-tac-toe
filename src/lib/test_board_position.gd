# gdlint: disable=class-definitions-order
extends GutTest


func before_each() -> void:
	pass


@warning_ignore("shadowed_variable")


class TestCase:
	var actual_row_index: int
	var actual_col_index: int
	var expected_string: String
	var to_index: int
	var is_valid: bool
	var is_error: bool

	@warning_ignore("shadowed_variable")

	func _init(
		actual_row_index: int,
		actual_col_index: int,
		expected_string: String,
		to_index: int,
		is_valid: bool,
		is_error: bool
	) -> void:
		self.actual_row_index = actual_row_index
		self.actual_col_index = actual_col_index
		self.expected_string = expected_string
		self.to_index = to_index
		self.is_valid = is_valid
		self.is_error = is_error


static var test_cases: Array[TestCase] = [
	TestCase.new(-1, -1, "BoardPosition(row=-1, col=-1)", -4, false, false),
	TestCase.new(0, 0, "BoardPosition(row=0, col=0)", 0, true, false),
	TestCase.new(0, 1, "BoardPosition(row=0, col=1)", 1, true, false),
	TestCase.new(0, 2, "BoardPosition(row=0, col=2)", 2, true, false),
	TestCase.new(0, 3, "BoardPosition(row=-1, col=-1)", -4, false, true),
	TestCase.new(1, 2, "BoardPosition(row=1, col=2)", 5, true, false),
	TestCase.new(3, 1, "BoardPosition(row=-1, col=-1)", -4, false, true),
]


func test_properties(test_case: TestCase = use_parameters(test_cases)) -> void:
	var actual := BoardPosition.new(test_case.actual_row_index, test_case.actual_col_index)

	assert_eq(actual.to_string(), test_case.expected_string)
	assert_eq(actual.to_index(), test_case.to_index)
	assert_eq(actual.is_valid(), test_case.is_valid)
