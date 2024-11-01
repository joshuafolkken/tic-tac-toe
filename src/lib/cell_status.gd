class_name CellStatus

enum State { EMPTY, X, O }

static var empty := CellStatus.new(State.EMPTY)
static var x := CellStatus.new(State.X)
static var o := CellStatus.new(State.O)

var _state: State


func _init(state: State = State.EMPTY) -> void:
	if state not in State.values():
		push_error("Invalid state: %s" % str(state))
		_state = State.EMPTY
	else:
		_state = state


func _to_string() -> String:
	return State.keys()[_state]


func get_value() -> State:
	return _state


func is_empty() -> bool:
	return _state == State.EMPTY


func is_not_empty() -> bool:
	return not is_empty()


func is_x() -> bool:
	return _state == State.X


func is_o() -> bool:
	return _state == State.O


func is_equal(other: CellStatus) -> bool:
	return _state == other._state


func is_equal_and_not_empty(other: CellStatus) -> bool:
	return is_not_empty() and is_equal(other)


static func from_game_player(game_player: GamePlayer) -> CellStatus:
	if game_player.is_x():
		return x
	if game_player.is_o():
		return o

	push_error("Invalid game player: %s" % game_player)
	return empty


func get_icon() -> String:
	if _state == State.X:
		return "X"
	if _state == State.O:
		return "O"

	return " "
