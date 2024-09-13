class_name GameplayTest
extends BaseTest


func test_click_cell() -> void:
	var first_position := BoardPosition.new(1, 1)
	var first_cell := _scene._ui_manager._cell_collection.get_element(first_position)
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
				var button := _scene._ui_manager._cell_collection.get_element(position)
				assert_bool(button._cell_button.visible).is_true()


func assert_cell_state(
	position: BoardPosition,
	is_button_visible: bool,
	is_cross_visible: bool,
	is_circle_visible: bool
) -> void:
	var cell := _scene._ui_manager._cell_collection.get_element(position)
	var button := cell._cell_button
	button.emit_signal("pressed")

	assert_bool(button.visible).is_equal(is_button_visible)
	assert_bool(cell._cross.visible).is_equal(is_cross_visible)
	assert_bool(cell._circle.visible).is_equal(is_circle_visible)


func test_click_three_cells() -> void:
	assert_cell_state(BoardPosition.new(1, 1), false, true, false)
	assert_cell_state(BoardPosition.new(0, 0), false, false, true)
	assert_cell_state(BoardPosition.new(2, 2), false, true, false)

	# その他のセルの状態を確認
	for row in range(3):
		for col in range(3):
			if (row != 1 or col != 1) and (row != 0 or col != 0) and (row != 2 or col != 2):
				var other_position := BoardPosition.new(row, col)
				var other_cell := _scene._ui_manager._cell_collection.get_element(other_position)
				assert_bool(other_cell._cell_button.visible).is_true()


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


func test_x_wins() -> void:
	var positions := [
		BoardPosition.new(0, 0),  # X
		BoardPosition.new(1, 1),  # O
		BoardPosition.new(0, 1),  # X
		BoardPosition.new(2, 2),  # O
		BoardPosition.new(0, 2),  # X
	]

	for position: BoardPosition in positions:
		var cell := _scene._ui_manager._cell_collection.get_element(position)
		cell._cell_button.emit_signal("pressed")

	assert_bool(_scene._ui_manager._status_label.visible).is_true()
	assert_str(_scene._ui_manager._status_label.text).is_equal("X Wins!")


func test_o_wins() -> void:
	var positions := [
		BoardPosition.new(0, 0),  # X
		BoardPosition.new(0, 1),  # O
		BoardPosition.new(1, 0),  # X
		BoardPosition.new(1, 1),  # O
		BoardPosition.new(2, 2),  # X
		BoardPosition.new(2, 1),  # O
	]

	for position: BoardPosition in positions:
		var cell := _scene._ui_manager._cell_collection.get_element(position)
		cell._cell_button.emit_signal("pressed")

	assert_bool(_scene._ui_manager._status_label.visible).is_true()
	assert_str(_scene._ui_manager._status_label.text).is_equal("O Wins!")

# func test_draw() -> void:
# 	assert_not_yet_implemented()

#var positions := [
#BoardPosition.new(0, 0),  # X
#BoardPosition.new(1, 1),  # O
#BoardPosition.new(0, 2),  # X
#BoardPosition.new(0, 1),  # O
#BoardPosition.new(2, 0),  # X
#BoardPosition.new(1, 0),  # O
#BoardPosition.new(1, 2),  # X
#BoardPosition.new(2, 1),  # O
#BoardPosition.new(2, 2),  # X
#]
#
#for position: BoardPosition in positions:
#var cell := _scene._cell_collection.get_element(position)
#cell._cell_button.emit_signal("pressed")
#
#assert_bool(_scene._status_label.visible).is_true()
#assert_str(_scene._status_label.text).is_equal("Draw!")
