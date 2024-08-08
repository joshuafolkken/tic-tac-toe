class_name Buttons

var _data: Array[CellButton2D] = []


func append(button: CellButton2D) -> void:
	if not Global.ensure_not_null(button, "Button"):
		return

	_data.append(button)


func end_game() -> void:
	for button in _data:
		button.set_button_visibility(false)


func reset_all() -> void:
	for button in _data:
		button.reset()


func validate_position(position: Vector2i) -> void:
	if not Global.ensure_not_null(position, "Position"):
		return

	if position.x < 0 or position.x > 2 or position.y < 0 or position.y > 2:
		Global.throw_exception("Position is out of bounds. x: %s, y: %s" % [position.x, position.y])
		return


func from_vector2i(position: Vector2i) -> CellButton2D:
	validate_position(position)

	var index = position.x * 3 + position.y
	return _data[index]


func clear(position: Vector2i) -> void:
	from_vector2i(position).reset()


func fade(position: Vector2i) -> void:
	from_vector2i(position).fade(true)
