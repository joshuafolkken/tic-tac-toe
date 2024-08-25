class_name Buttons

var _data: Array[CellButton2D] = []


func append(button: CellButton2D) -> void:
	_data.append(button)


func end_game() -> void:
	for button in _data:
		button.set_button_visibility(false)


func reset_all() -> void:
	for button in _data:
		button.reset()


func from_board_position(board_position: BoardPosition) -> CellButton2D:
	return _data[board_position.to_index()]


func clear(board_position: BoardPosition) -> void:
	from_board_position(board_position).reset()


func fade(board_position: BoardPosition) -> void:
	from_board_position(board_position).fade(true)
