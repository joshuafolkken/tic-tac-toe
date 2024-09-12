class_name GameManager
extends Node

signal game_ended(result: String)
signal player_changed(player: GamePlayer)

var _board: Board
var _position_history: PositionHistory
var _current_player: GamePlayer


func emit_player_changed() -> void:
	player_changed.emit.bind(_current_player)


func reset() -> void:
	_board = Board.new()
	_position_history = PositionHistory.new()
	_current_player = GamePlayer.new()
	emit_player_changed()


func _check_game_end() -> bool:
	var game_status := _board.get_game_status()

	if game_status.is_playing():
		return false

	var result_text := game_status.get_result_text()
	game_ended.emit(result_text)
	return true


func make_move(board_position: BoardPosition) -> Array[BoardPosition]:
	var cell_status := CellStatus.from_game_player(_current_player)
	_board.add(board_position, cell_status)

	var disappear_positions := _position_history.append(board_position)

	if disappear_positions[0].is_valid():
		_board.add_empty(disappear_positions[0])

	if not _check_game_end():
		_current_player = _current_player.next()
		emit_player_changed()

	return disappear_positions


func get_current_player() -> GamePlayer:
	return _current_player
