class_name BoardPosition

const INVALID_INDEX := -1
const MIN_INDEX := INVALID_INDEX
const MAX_SIZE := 3

var _row_index: int
var _col_index: int

static var invalid := BoardPosition.new(INVALID_INDEX, INVALID_INDEX)


static func create_all_board_positions() -> Array[BoardPosition]:
	var positions: Array[BoardPosition] = []

	for row_index in MAX_SIZE:
		for col_index in MAX_SIZE:
			positions.append(BoardPosition.new(row_index, col_index))

	return positions


func _is_valid_index(index: int) -> bool:
	return index >= MIN_INDEX and index < MAX_SIZE


func _is_valid(row_index: int, col_index: int) -> bool:
	return _is_valid_index(row_index) and _is_valid_index(col_index)


func _init(row_index: int, col_index: int) -> void:
	if not _is_valid(row_index, col_index):
		push_error("Invalid position: row_index=%d, col_index=%d" % [row_index, col_index])
		_row_index = INVALID_INDEX
		_col_index = INVALID_INDEX

	_row_index = row_index
	_col_index = col_index


func hash() -> int:
	return _row_index * MAX_SIZE + _col_index


static func from_hash(hash_value: int) -> BoardPosition:
	@warning_ignore("integer_division")
	var row_index := hash_value / MAX_SIZE
	var col_index := hash_value % MAX_SIZE

	return BoardPosition.new(row_index, col_index)


func _is_equal(other: BoardPosition) -> bool:
	return _row_index == other._row_index and _col_index == other._col_index


func _to_string() -> String:
	return "BoardPosition(row = %d, col = %d)" % [_row_index, _col_index]


func to_index() -> int:
	return _row_index * MAX_SIZE + _col_index


func is_valid() -> bool:
	return _row_index != INVALID_INDEX and _col_index != INVALID_INDEX
