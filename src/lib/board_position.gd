class_name BoardPosition

const INVALID_INDEX := -1
const MIN_INDEX := INVALID_INDEX
const MAX_SIZE := 3

static var invalid := BoardPosition.new(INVALID_INDEX, INVALID_INDEX)
static var _instances := _create_all_instances()
static var instances_array := _to_array()

var _row_index: int
var _col_index: int


static func create_hash(row_index: int, col_index: int) -> int:
	return row_index * MAX_SIZE + col_index


static func _create_all_instances() -> Dictionary:
	var elements: Dictionary = {}

	for row_index in MAX_SIZE:
		for col_index in MAX_SIZE:
			var key := create_hash(row_index, col_index)
			elements[key] = BoardPosition.new(row_index, col_index)

	return elements


static func get_instance(row_index: int, col_index: int) -> BoardPosition:
	var key := create_hash(row_index, col_index)

	return _instances[key]


static func _to_array() -> Array[BoardPosition]:
	var result: Array[BoardPosition] = []

	for value: BoardPosition in _instances.values():
		result.append(value)

	return result


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
	return create_hash(_row_index, _col_index)


static func from_hash(hash_value: int) -> BoardPosition:
	@warning_ignore("integer_division")
	var row_index := hash_value / MAX_SIZE
	var col_index := hash_value % MAX_SIZE

	return BoardPosition.get_instance(row_index, col_index)


func _is_equal(other: BoardPosition) -> bool:
	return _row_index == other._row_index and _col_index == other._col_index


func _to_string() -> String:
	return "BoardPosition(row = %d, col = %d)" % [_row_index, _col_index]


func to_index() -> int:
	return _row_index * MAX_SIZE + _col_index


func is_valid() -> bool:
	return _row_index != INVALID_INDEX and _col_index != INVALID_INDEX


func get_priority() -> int:
	if _row_index == 1 and _col_index == 1:
		return 2

	if (_row_index == 0 or _row_index == 2) and (_col_index == 0 or _col_index == 2):
		return 1

	return 0
