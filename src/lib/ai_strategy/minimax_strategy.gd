class_name MinimaxStrategy
extends AIStrategy

const MAX_SEARCH_DEPTH = 30
const WINNING_SCORE = 1000
const INITIAL_MIN_SCORE = -999999

var _current_player: GamePlayer
var _nodes_evaluated := 0


func _init(board: Board, current_player: GamePlayer) -> void:
	_current_player = current_player
	super(board)


func _calculate_end_game_score(game_status: GameStatus, player: GamePlayer, depth: int) -> int:
	_nodes_evaluated += 1

	if game_status.is_draw():
		return 0

	var score_with_depth := WINNING_SCORE - depth

	if game_status.is_x_win():
		return score_with_depth if player.is_x() else -score_with_depth

	if game_status.is_o_win():
		return score_with_depth if player.is_o() else -score_with_depth

	push_error("Invalid game status encountered")
	return 0


func _evaluate(depth: int, player: GamePlayer) -> int:
	var game_status := _board.get_game_status()

	if not game_status.is_playing():
		return _calculate_end_game_score(game_status, player, depth)

	if depth >= MAX_SEARCH_DEPTH:
		return 0

	var empty_positions := _board.get_empty_positions()
	if empty_positions.is_empty():
		return 0

	var best_score := INITIAL_MIN_SCORE
	var next_player := player.next()
	var cell_status := CellStatus.from_game_player(next_player)

	for position in empty_positions:
		_board.add(position, cell_status)

		var score := _evaluate(depth + 1, next_player)
		best_score = max(score, best_score)

		_board.add(position, CellStatus.empty)

	return -best_score


func choose_move() -> BoardPosition:
	var available_positions := _board.get_empty_positions()
	var best_score := INITIAL_MIN_SCORE
	var best_position := available_positions[0]
	var cell_status := CellStatus.from_game_player(_current_player)

	for current_position in available_positions:
		_board.add(current_position, cell_status)
		var current_score := _evaluate(0, _current_player)
		_board.add(current_position, CellStatus.empty)

		if current_score > best_score:
			best_score = current_score
			best_position = current_position

	prints("Nodes evaluated:", _nodes_evaluated)

	return best_position
