class_name Board

const EMPTY := 0

var _data := [
	[EMPTY, EMPTY, EMPTY],
	[EMPTY, EMPTY, EMPTY],
	[EMPTY, EMPTY, EMPTY],
]


func reset() -> void:
	for row in range(3):
		for col in range(3):
			_data[row][col] = EMPTY


func _init() -> void:
	reset()


func update(row_index: int, col_index: int, value: int) -> void:
	_data[row_index][col_index] = value


func set_empty(row_index: int, col_index: int) -> void:
	update(row_index, col_index, EMPTY)


func get_status() -> int:
	for row in _data:
		if row[0] != EMPTY and row[0] == row[1] and row[1] == row[2]:
			return row[0]

	for col in range(3):
		if (
			_data[0][col] != EMPTY
			and _data[0][col] == _data[1][col]
			and _data[1][col] == _data[2][col]
		):
			return _data[0][col]

	if _data[0][0] != EMPTY and _data[0][0] == _data[1][1] and _data[1][1] == _data[2][2]:
		return _data[0][0]

	if _data[0][2] != EMPTY and _data[0][2] == _data[1][1] and _data[1][1] == _data[2][0]:
		return _data[0][2]

	var is_full = true

	for row in _data:
		if not is_full:
			break

		for cell in row:
			if cell == EMPTY:
				is_full = false
				break

	if is_full:
		return -1

	return 0
