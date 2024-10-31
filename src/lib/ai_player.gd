class_name AIPlayer

signal moved(position: BoardPosition)

const MOVE_DELAY := 1.0

var _scene_tree: SceneTree
var _ai_strategy: AIStrategy


func _init(scene_tree: SceneTree, ai_strategy: AIStrategy) -> void:
	_scene_tree = scene_tree
	_ai_strategy = ai_strategy


func _get_best_move() -> BoardPosition:
	return _ai_strategy.choose_move()


func move() -> void:
	var position := _get_best_move()

	if position == BoardPosition.invalid:
		push_error("No move available: invalid position")
		return

	if position == null:
		push_error("No move available: empty position")
		return

	print(position._row_index, position._col_index)

	await _scene_tree.create_timer(MOVE_DELAY).timeout
	moved.emit(position)
