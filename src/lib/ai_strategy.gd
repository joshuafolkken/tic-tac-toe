class_name AIStrategy


func choose_move(_empty_positions: Array[BoardPosition]) -> BoardPosition:
	push_error("choose_move called on base AIStrategy class")
	return BoardPosition.invalid


class RandomStrategy:
	extends AIStrategy

	func choose_move(empty_positions: Array[BoardPosition]) -> BoardPosition:
		return empty_positions[randi() % empty_positions.size()]


class MinimaxStrategy:
	extends AIStrategy

	func choose_move(_empty_positions: Array[BoardPosition]) -> BoardPosition:
		push_error("Minimax strategy not implemented yet")
		return BoardPosition.invalid
