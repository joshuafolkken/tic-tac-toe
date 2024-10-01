class_name AIPlayer

signal moved(position: BoardPosition)

const MOVE_DELAY := 1.0

var _scene_tree: SceneTree
var _board: Board
var _ai_strategy: AIStrategy


func _init(scene_tree: SceneTree, board: Board, ai_strategy: AIStrategy) -> void:
	_scene_tree = scene_tree
	_board = board
	_ai_strategy = ai_strategy


func _get_best_move() -> BoardPosition:
	var empty_positions := _board.get_empty_positions()

	if empty_positions.is_empty():
		push_error("No empty cells available.")
		return BoardPosition.invalid

	return _ai_strategy.choose_move(empty_positions)


func move() -> void:
	var position := _get_best_move()

	if position == BoardPosition.invalid:
		push_error("No move available")
		return

	await _scene_tree.create_timer(MOVE_DELAY).timeout
	moved.emit(position)
