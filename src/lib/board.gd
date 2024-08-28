class_name Board

var _value: Dictionary = {}


func set_value(board_position: BoardPosition, cell_status: CellStatus) -> void:
	_value[board_position.hash()] = cell_status


func set_empty(board_position: BoardPosition) -> void:
	set_value(board_position, CellStatus.empty)


func _init() -> void:
	for row_index in range(BoardPosition.MAX_SIZE):
		for col_index in range(BoardPosition.MAX_SIZE):
			var position := BoardPosition.new(row_index, col_index)
			set_empty(position)


func get_value(board_position: BoardPosition) -> CellStatus:
	return _value[board_position.hash()]


func _are_all_same_and_not_empty(cell_statuses: Array[CellStatus]) -> bool:
	return cell_statuses.all(
		func(cell_status: CellStatus) -> bool: return cell_status.is_equal_and_not_empty(
			cell_statuses[0]
		)
	)


func _get_winner_if_all_same(cell_statuses: Array[CellStatus]) -> CellStatus:
	return cell_statuses[0] if _are_all_same_and_not_empty(cell_statuses) else CellStatus.empty


func _check_line(index: int, is_row: bool) -> CellStatus:
	var cell_statuses: Array[CellStatus] = []

	for i in range(BoardPosition.MAX_SIZE):
		var position := BoardPosition.new(index if is_row else i, index if not is_row else i)
		var value := get_value(position)
		cell_statuses.append(value)

	return _get_winner_if_all_same(cell_statuses)


func _check_lines(is_horizontal: bool) -> CellStatus:
	for i in range(BoardPosition.MAX_SIZE):
		var line_status := _check_line(i, is_horizontal)
		if line_status.is_not_empty():
			return line_status

	return CellStatus.empty


func _check_diagonal(reverse: bool) -> CellStatus:
	var cell_statuses: Array[CellStatus] = []

	for i in range(BoardPosition.MAX_SIZE):
		var col_index := BoardPosition.MAX_SIZE - i - 1 if reverse else i
		var position := BoardPosition.new(i, col_index)
		var value := get_value(position)
		cell_statuses.append(value)

	return _get_winner_if_all_same(cell_statuses)


func _is_full() -> bool:
	for row_index in range(BoardPosition.MAX_SIZE):
		for col_index in range(BoardPosition.MAX_SIZE):
			var position := BoardPosition.new(row_index, col_index)
			var value := get_value(position)

			if value.is_empty():
				return false

	return true


func _create_win_status(cell_status: CellStatus) -> GameStatus:
	return GameStatus.new(GameStatus.State.X_WIN if cell_status.is_x() else GameStatus.State.O_WIN)


func get_game_status() -> GameStatus:
	if _is_full():
		return GameStatus.draw

	var win_checks: Array[CellStatus] = [
		_check_lines(true), _check_lines(false), _check_diagonal(false), _check_diagonal(true)
	]

	for win_check in win_checks:
		if win_check.is_not_empty():
			return _create_win_status(win_check)

	return GameStatus.playing
