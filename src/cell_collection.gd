class_name CellCollection

var _elements: Array[Cell] = []


func append(button: Cell) -> void:
	_elements.append(button)


func end_game() -> void:
	for button in _elements:
		button.set_button_visibility(false)


func reset_all() -> void:
	for button in _elements:
		button.reset()


func _get_elements() -> Array[Cell]:
	return _elements


func _get_at(index: int) -> Cell:
	return _elements[index]


func get_element(board_position: BoardPosition) -> Cell:
	return _get_at(board_position.to_index())


func clear(board_position: BoardPosition) -> void:
	get_element(board_position).reset()


func fade(board_position: BoardPosition) -> void:
	get_element(board_position).fade(true)
