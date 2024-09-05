class_name PositionHistory

const MAX_SIZE = 6

var _elements: Array[BoardPosition] = []


func _init() -> void:
	for i in range(MAX_SIZE):
		_elements.append(BoardPosition.invalid)


func append(board_position: BoardPosition) -> Array[BoardPosition]:
	if _elements.size() > MAX_SIZE:
		_elements.pop_front()

	_elements.push_back(board_position)

	return [_elements[0], _elements[1]]


func _to_string() -> String:
	return str(_elements)
