class_name AIStrategy

var _board: Board


func _init(board: Board) -> void:
	_board = board


func choose_move() -> BoardPosition:
	push_error("choose_move called on base AIStrategy class")
	return BoardPosition.invalid
