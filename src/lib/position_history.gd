class_name PositionHistory

const MAX_SIZE = 6

var _data: Array[BoardPosition] = []


func _init() -> void:
	for i in range(MAX_SIZE):
		_data.append(BoardPosition.invalid)


func add(position: BoardPosition) -> Array[BoardPosition]:
	if _data.size() > MAX_SIZE:
		_data.pop_front()

	_data.push_back(position)

	return [_data[0], _data[1]]


func _to_string() -> String:
	return str(_data)
