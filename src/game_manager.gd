class_name GameManager
extends Node

signal game_ended(result: String)
signal player_changed(player: GamePlayer)
signal disappear_positions_changed(positions: Array[BoardPosition])
signal ai_player_moved(position: BoardPosition)

var _board: Board
var _position_history: PositionHistory
var _current_player: GamePlayer

var _is_infinite_enabled: bool
var _is_ai_player_enabled: bool


func emit_player_changed() -> void:
	player_changed.emit(_current_player)


func reset() -> void:
	_board = Board.new()
	_position_history = PositionHistory.new()
	_current_player = GamePlayer.new()

	# TODO: MODE SUPPORT
	_is_ai_player_enabled = true
	_is_infinite_enabled = false

	emit_player_changed()


func _check_game_end() -> bool:
	var game_status := _board.get_game_status()

	if game_status.is_playing():
		return false

	var result_text := game_status.get_result_text()
	game_ended.emit(result_text)
	return true


func _update_board(board_position: BoardPosition) -> void:
	var cell_status := CellStatus.from_game_player(_current_player)
	_board.add(board_position, cell_status)


func _disappear_cells(disappear_positions: Array[BoardPosition]) -> void:
	if disappear_positions[0].is_valid():
		_board.add_empty(disappear_positions[0])

	disappear_positions_changed.emit(disappear_positions)


func _update_board_history(board_position: BoardPosition) -> void:
	var disappear_positions := _position_history.append(board_position)

	if _is_infinite_enabled:
		_disappear_cells(disappear_positions)


func _on_ai_player_moved(position: BoardPosition) -> void:
	ai_player_moved.emit(position)


func is_ai_player() -> bool:
	return _is_ai_player_enabled and _current_player.is_o()


func _switch_player() -> void:
	_current_player = _current_player.next()
	emit_player_changed()


func _handle_ai_move() -> void:
	var ai_strategy := MinimaxStrategy.new(_board, _current_player)
	var ai_player := AIPlayer.new(get_tree(), ai_strategy)

	ai_player.moved.connect(_on_ai_player_moved)
	await ai_player.move()


func _update_game_state(board_position: BoardPosition) -> void:
	_update_board(board_position)
	_update_board_history(board_position)

	if _check_game_end():
		return

	_switch_player()

	if is_ai_player():
		await _handle_ai_move()


func make_move(board_position: BoardPosition) -> void:
	if board_position.is_valid():
		_update_game_state(board_position)


func get_current_player() -> GamePlayer:
	return _current_player
