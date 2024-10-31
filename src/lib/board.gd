class_name Board

var _elements: Dictionary = {}


func show() -> void:
	for x in BoardPosition.MAX_SIZE:
		var line := ""

		for y in BoardPosition.MAX_SIZE:
			var position := BoardPosition.new(x, y)
			var value := get_element(position)
			var cell_icon: String = value.get_icon()

			line += cell_icon

		print(line)


func add(board_position: BoardPosition, cell_status: CellStatus) -> void:
	_elements[board_position.hash()] = cell_status


func add_empty(board_position: BoardPosition) -> void:
	add(board_position, CellStatus.empty)


func _init() -> void:
	for position in BoardPosition.create_all_board_positions():
		add_empty(position)


func get_element(board_position: BoardPosition) -> CellStatus:
	return _elements[board_position.hash()]


func _check_line(index: int, is_row: bool) -> CellStatus:
	var cell_status_collection := CellStatusCollection.new()

	for i in BoardPosition.MAX_SIZE:
		var position := BoardPosition.new(index if is_row else i, index if not is_row else i)
		var value := get_element(position)
		cell_status_collection.append(value)

	return cell_status_collection.get_winner()


func _check_lines(is_horizontal: bool) -> CellStatus:
	for i in BoardPosition.MAX_SIZE:
		var line_status := _check_line(i, is_horizontal)
		if line_status.is_not_empty():
			return line_status

	return CellStatus.empty


func _check_diagonal(reverse: bool) -> CellStatus:
	var cell_status_collection := CellStatusCollection.new()

	for i in BoardPosition.MAX_SIZE:
		var col_index := BoardPosition.MAX_SIZE - i - 1 if reverse else i
		var position := BoardPosition.new(i, col_index)
		var value := get_element(position)
		cell_status_collection.append(value)

	return cell_status_collection.get_winner()


func _is_full() -> bool:
	return _elements.values().all(
		func(cell_status: CellStatus) -> bool: return cell_status.is_not_empty()
	)


func _create_win_status(cell_status: CellStatus) -> GameStatus:
	return GameStatus.new(GameStatus.State.X_WIN if cell_status.is_x() else GameStatus.State.O_WIN)


func get_game_status() -> GameStatus:
	var win_checks: Array[CellStatus] = [
		_check_lines(true), _check_lines(false), _check_diagonal(false), _check_diagonal(true)
	]

	for win_check in win_checks:
		if win_check.is_not_empty():
			return _create_win_status(win_check)

	if _is_full():
		return GameStatus.draw

	return GameStatus.playing


func get_empty_positions() -> Array[BoardPosition]:
	var empty_positions: Array[BoardPosition] = []

	for row_index in BoardPosition.MAX_SIZE:
		for col_index in BoardPosition.MAX_SIZE:
			var position := BoardPosition.new(row_index, col_index)
			var cell_status := get_element(position)

			if cell_status.is_empty():
				empty_positions.append(position)

	return empty_positions


func clone() -> Board:
	var new_board := Board.new()

	for position in BoardPosition.create_all_board_positions():
		var cell_status := get_element(position)
		new_board.add(position, cell_status)

	return new_board


func simulate_move(position: BoardPosition, player: GamePlayer) -> Board:
	var board_clone := clone()
	var cell_status := CellStatus.from_game_player(player)

	board_clone.add(position, cell_status)

	return board_clone
