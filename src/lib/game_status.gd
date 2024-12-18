class_name GameStatus

enum State { PLAYING, X_WIN, O_WIN, DRAW }

static var playing := GameStatus.new(State.PLAYING)
static var draw := GameStatus.new(State.DRAW)

var _state: State


func _init(state: State = State.PLAYING) -> void:
	if state not in State.values():
		push_error("Invalid state: %s" % str(state))
		_state = State.PLAYING
	else:
		_state = state


func is_playing() -> bool:
	return _state == State.PLAYING


func is_x_win() -> bool:
	return _state == State.X_WIN


func is_o_win() -> bool:
	return _state == State.O_WIN


func is_draw() -> bool:
	return _state == State.DRAW


func get_result_text() -> String:
	match _state:
		State.X_WIN:
			return "X Wins!"
		State.O_WIN:
			return "O Wins!"
		State.DRAW:
			return "Draw!"
		_:
			return "Playing!?"


func get_value() -> State:
	return _state
