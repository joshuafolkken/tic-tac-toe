class_name UIInfiniteTest
extends BaseInfiniteTest


func test_mark_fade_after_six_clicks() -> void:
	var positions := [
		BoardPosition.new(0, 0),
		BoardPosition.new(1, 1),
		BoardPosition.new(0, 1),
		BoardPosition.new(1, 0),
		BoardPosition.new(0, 2),
		BoardPosition.new(2, 0),
	]

	_scene._game_manager._is_infinite_enabled = true

	for position: BoardPosition in positions:
		var cell := _scene._ui_manager._cell_collection.get_element(position)
		cell._cell_button.emit_signal("pressed")

	var first_position: BoardPosition = positions[0]
	var first_cell := _scene._ui_manager._cell_collection.get_element(first_position)
	assert_float(first_cell.modulate.a).is_equal(0.5)

	for i in range(1, positions.size()):
		var position: BoardPosition = positions[i]
		var cell := _scene._ui_manager._cell_collection.get_element(position)
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

	_scene._game_manager._is_infinite_enabled = true

	for position: BoardPosition in positions:
		var cell := _scene._ui_manager._cell_collection.get_element(position)
		cell._cell_button.emit_signal("pressed")

	var first_position: BoardPosition = positions[0]
	var first_cell := _scene._ui_manager._cell_collection.get_element(first_position)

	assert_bool(first_cell._cell_button.visible).is_true()
	assert_bool(first_cell._cross.visible).is_false()
	assert_bool(first_cell._circle.visible).is_false()
	assert_float(first_cell.modulate.a).is_equal(1.0)

	var second_position: BoardPosition = positions[1]
	var second_cell := _scene._ui_manager._cell_collection.get_element(second_position)
	assert_float(second_cell.modulate.a).is_equal(0.5)
