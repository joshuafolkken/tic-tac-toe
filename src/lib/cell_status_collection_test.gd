# gdlint: disable=unused-argument
# gdlint: disable=private-method-call
# GdUnit generated TestSuite
class_name CellStatusCollectionTest
extends GdUnitTestSuite

@warning_ignore("unused_parameter")


func test_init() -> void:
	await assert_error(func() -> void: CellStatusCollection.new()).is_success()


@warning_ignore("unused_parameter")


func test_append(
	cell_state: CellStatus.State,
	expected: CellStatus.State,
	test_parameters := [
		[CellStatus.State.O, CellStatus.State.O],
		[CellStatus.State.X, CellStatus.State.X],
	]
) -> void:
	var collection := CellStatusCollection.new()
	var cell_status := CellStatus.new(cell_state)
	collection.append(cell_status)

	var actual := collection._get_at(0).get_value()
	assert_int(actual).is_equal(expected)


func test_get_at() -> void:
	pass  # yo, we're running that test in test_append() btw. icymi.


@warning_ignore("unused_parameter")


func test_is_empty(
	items: Array,
	expected: bool,
	test_parameters := [[[], true], [[CellStatus.empty], false]],
) -> void:
	var collection := CellStatusCollection.new()

	for item: CellStatus in items:
		collection.append(item)

	var actual := collection._is_empty()
	assert_bool(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_are_all_same_and_not_empty(
	items: Array,
	expected: bool,
	test_parameters := [
		[[], false],
		[[CellStatus.empty, CellStatus.empty, CellStatus.x], false],
		[[CellStatus.empty, CellStatus.x, CellStatus.x], false],
		[[CellStatus.x, CellStatus.x, CellStatus.x], true],
		[[CellStatus.x, CellStatus.x, CellStatus.o], false],
		[[CellStatus.x, CellStatus.o, CellStatus.o], false],
		[[CellStatus.o, CellStatus.o, CellStatus.o], true],
		[[CellStatus.o, CellStatus.x, CellStatus.o], false],
		[[CellStatus.o, CellStatus.empty, CellStatus.o], false],
	]
) -> void:
	var collection := CellStatusCollection.new()

	for item: CellStatus in items:
		collection.append(item)

	var actual := collection._are_all_same_and_not_empty()
	assert_bool(actual).is_equal(expected)


@warning_ignore("unused_parameter")


func test_get_winner(
	items: Array,
	expected: CellStatus,
	test_parameters := [
		[[], CellStatus.empty],
		[[CellStatus.empty, CellStatus.empty, CellStatus.empty], CellStatus.empty],
		[[CellStatus.empty, CellStatus.empty, CellStatus.x], CellStatus.empty],
		[[CellStatus.empty, CellStatus.x, CellStatus.x], CellStatus.empty],
		[[CellStatus.x, CellStatus.x, CellStatus.x], CellStatus.x],
		[[CellStatus.x, CellStatus.x, CellStatus.o], CellStatus.empty],
		[[CellStatus.x, CellStatus.o, CellStatus.o], CellStatus.empty],
		[[CellStatus.o, CellStatus.o, CellStatus.o], CellStatus.o],
		[[CellStatus.o, CellStatus.x, CellStatus.o], CellStatus.empty],
		[[CellStatus.o, CellStatus.empty, CellStatus.o], CellStatus.empty],
	]
) -> void:
	var collection := CellStatusCollection.new()

	for item in items:
		collection.append(item)

	var actual := collection.get_winner()
	assert_bool(actual.is_equal(expected)).is_true()
