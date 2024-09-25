# # gdlint: disable=unused-argument
# # gdlint: disable=private-method-call
# # GdUnit generated TestSuite
# class_name CellCollectionTest
# extends GdUnitTestSuite

# func test_init() -> void:
# 	await assert_error(func() -> void: CellCollection.new()).is_success()

# @warning_ignore("unused_parameter")

# func test_add(
# 	position: BoardPosition,
# 	cell: Cell,
# 	test_parameters := [
# 		[BoardPosition.new(0, 0), Cell.new()],
# 		[BoardPosition.new(1, 1), Cell.new()],
# 	]
# ) -> void:
# 	var collection := CellCollection.new()
# 	collection.add(position, cell)

# 	var actual := collection.get_element(position)
# 	assert_that(actual).is_equal(cell)

# func test_end_game() -> void:
# 	var collection := CellCollection.new()
# 	var cell1 := Cell.new()
# 	var cell2 := Cell.new()
# 	collection.add(BoardPosition.new(0, 0), cell1)
# 	collection.add(BoardPosition.new(1, 1), cell2)

# 	collection.end_game()

# 	assert_bool(cell1.button_visible).is_false()
# 	assert_bool(cell2.button_visible).is_false()

# 	cell1.free()
# 	cell2.free()

# func test_reset_all() -> void:
# 	var collection := CellCollection.new()
# 	var cell1 := Cell.new()
# 	var cell2 := Cell.new()

# 	collection.add(BoardPosition.new(0, 0), cell1)
# 	collection.add(BoardPosition.new(1, 1), cell2)
# 	collection.reset_all()

# 	assert_bool(cell1.button_visible).is_true()
# 	assert_bool(cell2.button_visible).is_true()

# 	cell1.free()
# 	cell2.free()

# func test_clear() -> void:
# 	var collection := CellCollection.new()
# 	var cell := Cell.new()
# 	var position := BoardPosition.new(0, 0)

# 	collection.add(position, cell)
# 	collection.clear(position)

# 	assert_bool(cell.button_visible).is_true()

# func test_fade() -> void:
# 	var collection := CellCollection.new()
# 	var cell := Cell.new()
# 	var position := BoardPosition.new(0, 0)

# 	collection.add(position, cell)
# 	collection.fade(position)

# 	assert_bool(cell.button_visible).is_false()
