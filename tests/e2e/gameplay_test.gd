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

	for row in BOARD_SIZE:
		for col in BOARD_SIZE:
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
	for row in 3:
		for col in 3:
			if (row != 1 or col != 1) and (row != 0 or col != 0) and (row != 2 or col != 2):
				var other_position := BoardPosition.new(row, col)
				var other_cell := _scene._ui_manager._cell_collection.get_element(other_position)
				assert_bool(other_cell._cell_button.visible).is_true()


func test_x_wins() -> void:
	var positions := [
		BoardPosition.new(0, 0),
		BoardPosition.new(1, 1),
		BoardPosition.new(0, 1),
		BoardPosition.new(2, 2),
		BoardPosition.new(0, 2),
	]

	for position: BoardPosition in positions:
		var cell := _scene._ui_manager._cell_collection.get_element(position)
		cell._cell_button.emit_signal("pressed")

	assert_bool(_scene._ui_manager._status_label.visible).is_true()
	assert_str(_scene._ui_manager._status_label.text).is_equal("X Wins!")


func test_o_wins() -> void:
	var positions := [
		BoardPosition.new(0, 0),
		BoardPosition.new(0, 1),
		BoardPosition.new(1, 0),
		BoardPosition.new(1, 1),
		BoardPosition.new(2, 2),
		BoardPosition.new(2, 1),
	]

	for position: BoardPosition in positions:
		var cell := _scene._ui_manager._cell_collection.get_element(position)
		cell._cell_button.emit_signal("pressed")

	assert_bool(_scene._ui_manager._status_label.visible).is_true()
	assert_str(_scene._ui_manager._status_label.text).is_equal("O Wins!")


func test_button_after_win() -> void:
	var positions := [
		BoardPosition.new(0, 0),
		BoardPosition.new(0, 1),
		BoardPosition.new(1, 1),
		BoardPosition.new(1, 2),
		BoardPosition.new(0, 2),
		BoardPosition.new(2, 2),
		BoardPosition.new(2, 0),
	]

	for position: BoardPosition in positions:
		var cell := _scene._ui_manager._cell_collection.get_element(position)
		cell._cell_button.emit_signal("pressed")

	assert_bool(_scene._ui_manager._status_label.visible).is_true()
	assert_str(_scene._ui_manager._status_label.text).is_equal("X Wins!")

	var first_cell := _scene._ui_manager._cell_collection.get_element(BoardPosition.new(0, 0))
	assert_bool(first_cell.button_visible).is_false()

# func test_draw() -> void:
# 	assert_not_yet_implemented()

#var positions := [
#BoardPosition.new(0, 0),
#BoardPosition.new(1, 1),
#BoardPosition.new(0, 2),
#BoardPosition.new(0, 1),
#BoardPosition.new(2, 0),
#BoardPosition.new(1, 0),
#BoardPosition.new(1, 2),
#BoardPosition.new(2, 1),
#BoardPosition.new(2, 2),
#]
#
#for position: BoardPosition in positions:
#var cell := _scene._cell_collection.get_element(position)
#cell._cell_button.emit_signal("pressed")
#
#assert_bool(_scene._status_label.visible).is_true()
#assert_str(_scene._status_label.text).is_equal("Draw!")
