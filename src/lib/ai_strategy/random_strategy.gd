class_name RandomStrategy
extends AIStrategy


func choose_move() -> BoardPosition:
	var empty_positions := _board.get_empty_positions()

	if empty_positions.is_empty():
		push_error("No empty cells available.")
		return BoardPosition.invalid

	return empty_positions[randi() % empty_positions.size()]
