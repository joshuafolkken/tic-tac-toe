class_name GameplayNormalTest
extends BaseNormalTest

# func test_draw() -> void:
# 	var positions := [
# 		BoardPosition.new(0, 0),
# 		BoardPosition.new(0, 1),
# 		BoardPosition.new(0, 2),
# 		BoardPosition.new(1, 0),
# 		BoardPosition.new(1, 2),
# 		BoardPosition.new(1, 1),
# 		BoardPosition.new(2, 0),
# 		BoardPosition.new(2, 2),
# 		BoardPosition.new(2, 1),
# 	]

# 	for position: BoardPosition in positions:
# 		var cell := _scene._ui_manager._cell_collection.get_element(position)
# 		cell._cell_button.emit_signal("pressed")

# 	assert_bool(_scene._ui_manager._status_label.visible).is_true()
# 	assert_str(_scene._ui_manager._status_label.text).is_equal("Draw!")

# func test_x_wins() -> void:
# 	var positions := [
# 		BoardPosition.new(0, 0),
# 		BoardPosition.new(0, 1),
# 		BoardPosition.new(0, 2),
# 		BoardPosition.new(1, 0),
# 		BoardPosition.new(1, 2),
# 		BoardPosition.new(1, 1),
# 		BoardPosition.new(2, 1),
# 		BoardPosition.new(2, 0),
# 		BoardPosition.new(2, 2),
# 	]

# 	for position: BoardPosition in positions:
# 		var cell := _scene._ui_manager._cell_collection.get_element(position)
# 		cell._cell_button.emit_signal("pressed")

# 	assert_bool(_scene._ui_manager._status_label.visible).is_true()
# 	assert_str(_scene._ui_manager._status_label.text).is_equal("X Wins!")
