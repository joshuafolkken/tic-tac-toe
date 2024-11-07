class_name AIPlayer

signal moved(position: BoardPosition)

const MOVE_DELAY := 0.2

var _scene_tree: SceneTree
var _ai_strategy: AIStrategy


func _init(scene_tree: SceneTree, ai_strategy: AIStrategy) -> void:
	_scene_tree = scene_tree
	_ai_strategy = ai_strategy


func _get_best_move() -> BoardPosition:
	await _scene_tree.process_frame
	return _ai_strategy.choose_move()


func move() -> void:
	var start_time := Time.get_ticks_msec()

	Log.d("begin")
	var position := await _get_best_move()
	Log.d("end")

	if position == BoardPosition.invalid:
		push_error("No move available: invalid position")
		return

	if position == null:
		push_error("No move available: empty position")
		return

	var end_time := Time.get_ticks_msec()
	var elapsed_time := (end_time - start_time) / 1000.0

	if elapsed_time < MOVE_DELAY:
		await _scene_tree.create_timer(MOVE_DELAY - elapsed_time).timeout

	moved.emit(position)
