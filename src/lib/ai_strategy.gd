class_name AIStrategy

var _board: Board
var _is_ai_active: bool


func _init(board: Board) -> void:
	_board = board
	_is_ai_active = true


func choose_move() -> BoardPosition:
	push_error("choose_move called on base AIStrategy class")
	return BoardPosition.invalid


func stop() -> void:
	_is_ai_active = false


func is_active() -> bool:
	return _is_ai_active
