class_name GameManager
extends Node

signal game_ended(result: String)
signal player_changed(player: GamePlayer)
signal board_updated(board: Board, current_player: GamePlayer)
signal ai_reset

var _board: Board
var _current_player: GamePlayer

var _is_infinite_enabled := false
var _is_ai_player_x_enabled: bool
var _is_ai_player_o_enabled: bool
var _ai_delay_sec := 1.0
var _ai_player: AIPlayer


func emit_player_changed() -> void:
	if is_ai_player():
		await _handle_ai_move()

	player_changed.emit(_current_player)


func reset(
	ai_delay_sec: float, is_ai_player_x_enabled: bool = false, is_ai_player_o_enabled: bool = false
) -> void:
	if _ai_player != null:
		_ai_player.stop()

	_is_infinite_enabled = not (is_ai_player_x_enabled and is_ai_player_o_enabled)

	_ai_delay_sec = ai_delay_sec
	_board = Board.new(_is_infinite_enabled)
	_current_player = GamePlayer.new()

	_is_ai_player_x_enabled = is_ai_player_x_enabled
	_is_ai_player_o_enabled = is_ai_player_o_enabled

	emit_player_changed()


func _check_game_end() -> bool:
	var game_status := _board.get_game_status()

	if game_status.is_playing():
		return false

	if _is_ai_player_x_enabled and _is_ai_player_o_enabled:
		ai_reset.emit()

	else:
		var result_text := game_status.get_result_text()
		game_ended.emit(result_text)

	return true


func _update_board(board_position: BoardPosition) -> void:
	var cell_status := CellStatus.from_game_player(_current_player)
	_board.add(board_position, cell_status)

	board_updated.emit(_board, _current_player)


func is_ai_player() -> bool:
	return (
		(_is_ai_player_x_enabled and _current_player.is_x())
		or (_is_ai_player_o_enabled and _current_player.is_o())
	)


func _switch_player() -> void:
	_current_player = _current_player.next()
	emit_player_changed()


func _update_game_state(board_position: BoardPosition) -> void:
	_update_board(board_position)

	if _check_game_end():
		return

	_switch_player()


func _on_ai_player_moved(position: BoardPosition) -> void:
	_update_game_state(position)


func _handle_ai_move() -> void:
	var ai_strategy := MinimaxStrategy.new(_board, _current_player)
	_ai_player = AIPlayer.new(get_tree(), ai_strategy, _ai_delay_sec)

	_ai_player.moved.connect(_on_ai_player_moved)

	await _ai_player.move()


func make_move(board_position: BoardPosition) -> void:
	if board_position.is_valid():
		_update_game_state(board_position)


func get_current_player() -> GamePlayer:
	return _current_player
