class_name MinimaxStrategy
extends AIStrategy

const MAX_DEPTH = 10
const DEFAULT_SCORE = 10
const MIN_SCORE = -999999

var _current_player: GamePlayer


func _init(board: Board, current_player: GamePlayer) -> void:
	_current_player = current_player

	super(board)


func _get_score(depth: int, position: BoardPosition, player: GamePlayer) -> int:
	var cell_status := CellStatus.from_game_player(player)
	var board := _board.clone()

	board.add(position, cell_status)

	var game_status := board.get_game_status()

	if game_status.is_playing():
		if depth >= MAX_DEPTH:
			return 0

		var next_player := player.next()
		var strategy := MinimaxStrategy.new(board, next_player)
		var score := strategy.get_high_score(depth + 1, next_player)

		return -score

	if game_status.is_x_win():
		return DEFAULT_SCORE if player.is_x() else DEFAULT_SCORE * -1

	if game_status.is_o_win():
		return DEFAULT_SCORE if player.is_o() else DEFAULT_SCORE * -1

	if game_status.is_draw():
		return 0

	push_error("not match game_status:", game_status)
	return 0


func get_high_score(depth: int, player: GamePlayer) -> int:
	var high_score := MIN_SCORE

	var empty_positions := _board.get_empty_positions()

	if empty_positions.is_empty():
		push_error("No empty cells available.")
		return 0

	for position in empty_positions:
		var score := _get_score(depth, position, player)

		if score > high_score:
			high_score = score

	return high_score


func choose_move() -> BoardPosition:
	var current_player := _current_player
	var high_score := MIN_SCORE
	var best_position: BoardPosition = null

	var empty_positions := _board.get_empty_positions()

	if empty_positions.is_empty():
		push_error("No empty cells available.")
		return BoardPosition.invalid

	for position in empty_positions:
		var score := _get_score(0, position, current_player)

		if score > high_score or best_position == null:
			high_score = score
			best_position = position

			print(score, best_position)

	return best_position

	# _board.add(next_position, cell_status)

	# var game_status = _board.get_game_status()

	# match game_status.get_value():
	# 	GameStatus.State.PLAYING:

	# 現在のボード状態を保存する
	# 空のポジションから一つをランダム選ぶ
	# 勝敗をチェックする。勝ち 10, まけ -10, 引き分け 0、結果が出れば値を返す
	# 勝敗が決まっていなければ、相手に変わってチェックする
