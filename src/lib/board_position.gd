class_name BoardPosition

const INVALID_INDEX := -1
const MAX_SIZE := 3

var _row_index: int
var _col_index: int

static var invalid := BoardPosition.new(INVALID_INDEX, INVALID_INDEX)


func _init(row_index: int, col_index: int) -> void:
	if (
		row_index < INVALID_INDEX
		or row_index >= MAX_SIZE
		or col_index < INVALID_INDEX
		or col_index >= MAX_SIZE
	):
		push_error("Invalid position: row_index=%d, col_index=%d" % [row_index, col_index])
		_row_index = INVALID_INDEX
		_col_index = INVALID_INDEX
	else:
		_row_index = row_index
		_col_index = col_index


func hash() -> int:
	return hash([_row_index, _col_index])


func _to_string() -> String:
	return "BoardPosition(row = %d, col = %d)" % [_row_index, _col_index]


func to_index() -> int:
	return _row_index * MAX_SIZE + _col_index


func is_valid() -> bool:
	return _row_index != INVALID_INDEX and _col_index != INVALID_INDEX
