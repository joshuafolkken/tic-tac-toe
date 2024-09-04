class_name CellCcollection

var _elements: Dictionary = {}


func add(position: BoardPosition, cell: Cell) -> void:
	_elements[position.hash()] = cell


func end_game() -> void:
	for cell: Cell in _elements.values():
		cell.set_button_visibility(false)


func reset_all() -> void:
	for cell: Cell in _elements.values():
		cell.reset()


func get_element(position: BoardPosition) -> Cell:
	return _elements[position.hash()]


func clear(position: BoardPosition) -> void:
	get_element(position).reset()


func fade(position: BoardPosition) -> void:
	get_element(position).fade(true)


func _get_all_cells() -> Array[Cell]:
	return _elements.values()


func _get_all_positions() -> Array[BoardPosition]:
	return _elements.keys()
