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


func from_vector2i(position: Vector2i) -> CellButton2D:
	var index = position.x * 3 + position.y
	return _data[index]


func clear(position: Vector2i) -> void:
	from_vector2i(position).reset()


func fade(position: Vector2i) -> void:
	from_vector2i(position).fade(true)
