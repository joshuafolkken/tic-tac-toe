class_name UINormalTest
extends BaseNormalTest

# func test_mark_not_fade_after_six_clicks() -> void:
# 	var positions := [
# 		BoardPosition.new(0, 0),
# 		BoardPosition.new(1, 1),
# 		BoardPosition.new(0, 1),
# 		BoardPosition.new(1, 0),
# 		BoardPosition.new(0, 2),
# 		BoardPosition.new(2, 0),
# 	]

# 	for position: BoardPosition in positions:
# 		var cell := _scene._ui_manager._cell_collection.get_element(position)
# 		cell._cell_button.emit_signal("pressed")

# 	for i in positions.size():
# 		var position: BoardPosition = positions[i]
# 		var cell := _scene._ui_manager._cell_collection.get_element(position)
# 		assert_float(cell.modulate.a).is_equal(1.0)
