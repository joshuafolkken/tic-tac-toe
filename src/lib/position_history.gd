class_name PositionHistory

const MAX_SIZE = 6

var _elements: Array[BoardPosition] = []


func _init() -> void:
	for i in MAX_SIZE:
		_elements.append(BoardPosition.invalid)


func append(board_position: BoardPosition) -> BoardPosition:
	if _elements.size() > MAX_SIZE:
		_elements.pop_front()

	_elements.push_back(board_position)

	return _elements[0]


func _to_string() -> String:
	return str(_elements)


func duplicate() -> PositionHistory:
	var position_history := PositionHistory.new()

	position_history._elements = _elements.duplicate()

	return position_history


func get_fade_position() -> BoardPosition:
	return _elements[1]
