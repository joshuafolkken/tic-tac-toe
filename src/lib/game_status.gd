class_name GameStatus

enum State { PLAYING, X_WIN, O_WIN, DRAW }

var _state: State

static var playing := GameStatus.new(State.PLAYING)
static var draw := GameStatus.new(State.DRAW)


func _init(state: State = State.PLAYING) -> void:
	if state not in State.values():
		push_error("Invalid state: %s" % str(state))
		_state = State.PLAYING
	else:
		_state = state


func is_playing() -> bool:
	return _state == State.PLAYING


func get_result_text() -> String:
	match _state:
		State.X_WIN:
			return "X Wins!"
		State.O_WIN:
			return "O Wins!"
		_:
			return "Draw!"
