class_name Board

var _cell_status_dictionary: Dictionary = {}
var _position_history := PositionHistory.new()
# TODO: MODE SUPPORT
var _is_infinite_enabled: bool


func _init(is_infinite_enabled: bool) -> void:
	_is_infinite_enabled = is_infinite_enabled

	for position in BoardPosition.instances_array:
		add_empty(position)


func show() -> void:
	for x in BoardPosition.MAX_SIZE:
		var line := ""

		for y in BoardPosition.MAX_SIZE:
			var position := BoardPosition.get_instance(x, y)
			var value := get_element(position)
			var cell_icon: String = value.get_icon()

			line += cell_icon

		print(line)


func _update_history(board_position: BoardPosition) -> void:
	var disappear_position := _position_history.append(board_position)

	if disappear_position.is_valid():
		add_empty(disappear_position)


func duplicate() -> Board:
	var board := Board.new(_is_infinite_enabled)

	board._cell_status_dictionary = _cell_status_dictionary.duplicate()
	board._position_history = _position_history.duplicate()

	return board


func add(board_position: BoardPosition, cell_status: CellStatus) -> void:
	_cell_status_dictionary[board_position.hash()] = cell_status

	if _is_infinite_enabled:
		_update_history(board_position)


func add_empty(board_position: BoardPosition) -> void:
	_cell_status_dictionary[board_position.hash()] = CellStatus.empty


func get_element(board_position: BoardPosition) -> CellStatus:
	return _cell_status_dictionary[board_position.hash()]


func _check_line(index: int, is_row: bool) -> CellStatus:
	var result: CellStatus = null

	for i in BoardPosition.MAX_SIZE:
		var key := BoardPosition.create_hash(index if is_row else i, index if not is_row else i)
		var cell_status: CellStatus = _cell_status_dictionary[key]

		if cell_status.is_empty():
			return cell_status

		if i == 0:
			result = cell_status

		if result != cell_status:
			return CellStatus.empty

	return result


func _check_lines(is_horizontal: bool) -> CellStatus:
	for i in BoardPosition.MAX_SIZE:
		var line_status := _check_line(i, is_horizontal)
		if line_status.is_not_empty():
			return line_status

	return CellStatus.empty


func _check_diagonal(reverse: bool) -> CellStatus:
	var result: CellStatus = null

	for i in BoardPosition.MAX_SIZE:
		var col_index := BoardPosition.MAX_SIZE - i - 1 if reverse else i
		var key := BoardPosition.create_hash(i, col_index)
		var cell_status: CellStatus = _cell_status_dictionary[key]

		if cell_status.is_empty():
			return cell_status

		if i == 0:
			result = cell_status

		if result != cell_status:
			return CellStatus.empty

	return result


func _is_full() -> bool:
	for cell_status: CellStatus in _cell_status_dictionary.values():
		if cell_status.is_empty():
			return false

	return true


func _create_win_status(cell_status: CellStatus) -> GameStatus:
	return GameStatus.new(GameStatus.State.X_WIN if cell_status.is_x() else GameStatus.State.O_WIN)


func get_game_status() -> GameStatus:
	var check_lines_true := _check_lines(true)

	if check_lines_true.is_not_empty():
		return _create_win_status(check_lines_true)

	var check_lines_false := _check_lines(false)

	if check_lines_false.is_not_empty():
		return _create_win_status(check_lines_false)

	var check_diagonal_true := _check_diagonal(true)

	if check_diagonal_true.is_not_empty():
		return _create_win_status(check_diagonal_true)

	var check_diagonal_false := _check_diagonal(false)

	if check_diagonal_false.is_not_empty():
		return _create_win_status(check_diagonal_false)

	if _is_full():
		return GameStatus.draw

	return GameStatus.playing


func get_empty_positions() -> Array[BoardPosition]:
	var positions := BoardPosition.instances_array
	var empty_positions: Array[BoardPosition] = []

	for position in positions:
		var cell_status := get_element(position)

		if cell_status.is_empty():
			empty_positions.append(position)

	return empty_positions


func hash() -> String:
	var hash_string: String = ""

	for position in BoardPosition.instances_array:
		var cell_status := get_element(position)
		hash_string += cell_status.get_icon()

	return hash_string


func get_fade_position() -> BoardPosition:
	return _position_history.get_fade_position()
