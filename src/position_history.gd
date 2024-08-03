class_name PositionHistory

const MAX_SIZE = 6
const INVALID_POSITION = Vector2(-1, -1)

var _data: Array[Vector2] = []


func reset() -> void:
	_data.clear()

	for i in range(MAX_SIZE):
		_data.append(INVALID_POSITION)


func _init() -> void:
	reset()


func add(position: Vector2) -> Array[Vector2]:
	if _data.size() > MAX_SIZE:
		_data.pop_front()

	_data.push_back(position)

	print(to_string())

	return [_data[0], _data[1]]


func _to_string() -> String:
	return str(_data)