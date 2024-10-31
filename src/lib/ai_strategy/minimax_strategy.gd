class_name MinimaxStrategy
extends AIStrategy

const MAX_SEARCH_DEPTH = 5
const WINNING_SCORE = 1000
const INITIAL_MIN_SCORE = -999999

var _current_player: GamePlayer


func _init(board: Board, current_player: GamePlayer) -> void:
	_current_player = current_player
	super(board)


func _calculate_end_game_score(game_status: GameStatus, player: GamePlayer, depth: int) -> int:
	if game_status.is_draw():
		return 0

	var score_with_depth := WINNING_SCORE - depth

	if game_status.is_x_win():
		return score_with_depth if player.is_x() else -score_with_depth

	if game_status.is_o_win():
		return score_with_depth if player.is_o() else -score_with_depth

	push_error("Invalid game status encountered")
	return 0


func _get_next_player_score(depth: int, board: Board, current_player: GamePlayer) -> int:
	var next_player := current_player.next()
	var strategy := MinimaxStrategy.new(board, next_player)
	var score := strategy.get_high_score(depth + 1, next_player)

	return score


func _evaluate_position(depth: int, position: BoardPosition, player: GamePlayer) -> int:
	var simulated_board := _board.simulate_move(position, player)
	var game_status := simulated_board.get_game_status()

	if not game_status.is_playing():
		return _calculate_end_game_score(game_status, player, depth)

	if depth >= MAX_SEARCH_DEPTH:
		return 0

	return -_get_next_player_score(depth, simulated_board, player)


func get_high_score(depth: int, player: GamePlayer) -> int:
	var empty_positions := _board.get_empty_positions()

	if empty_positions.is_empty():
		push_error("No empty cells available.")
		return 0

	var high_score := INITIAL_MIN_SCORE

	for position in empty_positions:
		var score := _evaluate_position(depth, position, player)
		high_score = max(score, high_score)

	return high_score


func choose_move() -> BoardPosition:
	var available_positions := _board.get_empty_positions()
	var best_score := INITIAL_MIN_SCORE
	var best_position := available_positions[0]

	for current_position in available_positions:
		var current_score := _evaluate_position(0, current_position, _current_player)

		if current_score > best_score:
			best_score = current_score
			best_position = current_position

	return best_position
