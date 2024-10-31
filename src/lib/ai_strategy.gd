class_name AIStrategy

var _board: Board


func _init(board: Board) -> void:
	_board = board


func choose_move() -> BoardPosition:
	push_error("choose_move called on base AIStrategy class")
	return BoardPosition.invalid


class RandomStrategy:
	extends AIStrategy

	func choose_move() -> BoardPosition:
		var empty_positions := _board.get_empty_positions()

		if empty_positions.is_empty():
			push_error("No empty cells available.")
			return BoardPosition.invalid

		return empty_positions[randi() % empty_positions.size()]
