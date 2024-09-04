class_name UITest
extends BaseTest


func test_click_cell() -> void:
	var first_position := BoardPosition.new(1, 1)
	var first_cell := _scene._cell_collection.get_element(first_position)
	var first_button := first_cell._cell_button

	first_button.emit_signal("pressed")

	var cross := first_cell._cross
	var circle := first_cell._circle

	assert_bool(first_button.visible).is_false()
	assert_bool(cross.visible).is_true()
	assert_bool(circle.visible).is_false()

	for row in range(3):
		for col in range(3):
			if row != 1 or col != 1:
				var position := BoardPosition.new(row, col)
				var button := _scene._cell_collection.get_element(position)
				assert_bool(button._cell_button.visible).is_true()


func test_click_three_cells() -> void:
	var first_position := BoardPosition.new(1, 1)
	var first_cell := _scene._cell_collection.get_element(first_position)
	first_cell._cell_button.emit_signal("pressed")

	var second_position := BoardPosition.new(0, 0)
	var second_cell := _scene._cell_collection.get_element(second_position)
	var second_button := second_cell._cell_button

	second_button.emit_signal("pressed")

	assert_bool(second_button.visible).is_false()
	assert_bool(second_cell._cross.visible).is_false()
	assert_bool(second_cell._circle.visible).is_true()

	var third_position := BoardPosition.new(2, 2)
	var third_cell := _scene._cell_collection.get_element(third_position)
	var third_button := third_cell._cell_button

	third_button.emit_signal("pressed")

	assert_bool(third_button.visible).is_false()
	assert_bool(third_cell._cross.visible).is_true()
	assert_bool(third_cell._circle.visible).is_false()


func test_mark_fade_after_six_clicks() -> void:
	var positions := [
		BoardPosition.new(0, 0),
		BoardPosition.new(1, 1),
		BoardPosition.new(0, 1),
		BoardPosition.new(1, 0),
		BoardPosition.new(0, 2),
		BoardPosition.new(2, 0),
	]

	for position: BoardPosition in positions:
		var cell := _scene._cell_collection.get_element(position)
		cell._cell_button.emit_signal("pressed")

	var first_position: BoardPosition = positions[0]
	var first_cell := _scene._cell_collection.get_element(first_position)
	assert_float(first_cell.modulate.a).is_equal(0.5)

	for i in range(1, positions.size()):
		var position: BoardPosition = positions[i]
		var cell := _scene._cell_collection.get_element(position)
		assert_float(cell.modulate.a).is_equal(1.0)


func test_mark_disappear_after_seven_clicks() -> void:
	var positions := [
		BoardPosition.new(0, 0),
		BoardPosition.new(1, 1),
		BoardPosition.new(0, 1),
		BoardPosition.new(1, 0),
		BoardPosition.new(0, 2),
		BoardPosition.new(2, 0),
		BoardPosition.new(2, 1),
	]

	for position: BoardPosition in positions:
		var cell := _scene._cell_collection.get_element(position)
		cell._cell_button.emit_signal("pressed")

	var first_position: BoardPosition = positions[0]
	var first_cell := _scene._cell_collection.get_element(first_position)

	assert_bool(first_cell._cell_button.visible).is_true()
	assert_bool(first_cell._cross.visible).is_false()
	assert_bool(first_cell._circle.visible).is_false()
	assert_float(first_cell.modulate.a).is_equal(1.0)

	var second_position: BoardPosition = positions[1]
	var second_cell := _scene._cell_collection.get_element(second_position)
	assert_float(second_cell.modulate.a).is_equal(0.5)
