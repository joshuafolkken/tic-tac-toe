class_name MinimaxStrategy
extends AIStrategy

const MAX_DEPTH = 9
const WIN_SCORE = 10
const INITIAL_ALPHA = -999999
const INITIAL_BETA = 999999

var _current_player: GamePlayer
var _nodes_evaluated := 0
# var _transposition_table := {}


func _init(board: Board, current_player: GamePlayer) -> void:
	_current_player = current_player
	super(board)


func _calculate_end_game_score(game_status: GameStatus, player: GamePlayer, depth: int) -> int:
	_nodes_evaluated += 1

	if game_status.is_draw():
		return 0

	var score_with_depth := WIN_SCORE - depth

	if game_status.is_x_win():
		return score_with_depth if player.is_x() else -score_with_depth

	if game_status.is_o_win():
		return score_with_depth if player.is_o() else -score_with_depth

	push_error("Invalid game status encountered")
	return 0


func _evaluate(depth: int, player: GamePlayer, alpha: int, beta: int) -> int:
	var game_status := _board.get_game_status()

	if not game_status.is_playing():
		return _calculate_end_game_score(game_status, player, depth)

	# MEMO: 現在の実装ではトランスポジションテーブルは使えない模様
	# var board_hash := "%s_%d" % [_board.hash(), depth]
	# if _transposition_table.has(board_hash):
	# 	return _transposition_table[board_hash]

	if depth >= MAX_DEPTH:
		return 0

	var empty_positions := _board.get_empty_positions()
	if empty_positions.is_empty():
		return 0

	var next_player := player.next()
	var cell_status := CellStatus.from_game_player(next_player)
	var current_alpha := alpha
	var best_score := INITIAL_ALPHA

	for position in empty_positions:
		_board.add(position, cell_status)
		var score := _evaluate(depth + 1, next_player, -beta, -current_alpha)
		_board.add(position, CellStatus.empty)

		best_score = max(best_score, score)
		current_alpha = max(current_alpha, score)
		if current_alpha >= beta:
			break

	# _transposition_table[board_hash] = -best_score
	# prints(board_hash, -best_score)

	return -best_score


static func pick_random(available_positions: Array[BoardPosition]) -> BoardPosition:
	available_positions = available_positions.filter(
		func(position: BoardPosition) -> bool: return position.get_priority() >= 1
	)

	return available_positions.pick_random()


func choose_move() -> BoardPosition:
	_nodes_evaluated = 0

	var available_positions := _board.get_empty_positions()

	if available_positions.size() == BoardPosition.MAX_SIZE ** 2:
		return pick_random(available_positions)

	if available_positions.size() == BoardPosition.MAX_SIZE ** 2 - 1:
		available_positions.sort_custom(
			func(a: BoardPosition, b: BoardPosition) -> int:
				return a.get_priority() > b.get_priority()
		)

		if available_positions[0].get_priority() == 2:
			return available_positions[0]

		return pick_random(available_positions)

	var best_score := INITIAL_ALPHA
	var best_position := available_positions[0]
	var cell_status := CellStatus.from_game_player(_current_player)

	for current_position in available_positions:
		_board.add(current_position, cell_status)
		var current_score := _evaluate(0, _current_player, INITIAL_ALPHA, INITIAL_BETA)
		_board.add(current_position, CellStatus.empty)

		if current_score > best_score:
			best_score = current_score
			best_position = current_position

	prints("Nodes evaluated:", _nodes_evaluated)

	return best_position
