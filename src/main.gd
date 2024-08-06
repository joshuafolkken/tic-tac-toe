extends Node

enum GameStatus {
	DRAW = -1,
	PLAYING = 0,
	X_WIN = 1,
	Y_WIN = 2,
}

var buttons := []

var current_player_id := 0
var board := Board.new()
var position_history := PositionHistory.new()

@onready var cells := $Cells
@onready var reset_button := $ResetButton
@onready var click_sound: ClickSound = $ClickSound
@onready var status_label := $StatusLabel


func _get_result_text(game_end_status: int) -> String:
	match game_end_status:
		GameStatus.X_WIN:
			return "X Wins!"
		GameStatus.Y_WIN:
			return "O Wins!"
		_:
			return "Draw!"


func _update_status_label(text: String) -> void:
	status_label.text = text
	status_label.visible = true


func _check_game_end() -> bool:
	var board_status := board.get_status()

	if board_status == GameStatus.PLAYING:
		return false

	var label_text := _get_result_text(board_status)
	_update_status_label(label_text)

	for button in buttons:
		button.set_button_visibility(false)

	click_sound.play_game_end()

	return true


func _disappear_cells(positions: Array[Vector2]) -> void:
	if positions[0] != PositionHistory.INVALID_POSITION:
		var index = positions[0].x * 3 + positions[0].y
		var button = buttons[index] as CellButton2D
		button.reset()
		board.set_empty(positions[0].x as int, positions[0].y as int)

	if positions[1] != PositionHistory.INVALID_POSITION:
		var index = positions[1].x * 3 + positions[1].y
		var button = buttons[index] as CellButton2D
		button.disappear(true)


func _on_button_clicked(row_index: int, col_index: int, cell_button_2d: CellButton2D) -> void:
	# print("button pressed: row: %d, col: %d" % [row_index, col_index])

	var status := current_player_id + 1
	board.update(row_index, col_index, status)
	cell_button_2d.update_status(status)

	var disappear_positions := position_history.add(Vector2(row_index, col_index))
	_disappear_cells(disappear_positions)

	if _check_game_end():
		return

	current_player_id = (current_player_id + 1) % 2


func _on_reset_button_pressed() -> void:
	board.reset()
	position_history.reset()

	for button in buttons:
		button.reset()

	current_player_id = 0
	status_label.visible = false

	click_sound.play_reset()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_button.pressed.connect(_on_reset_button_pressed)

	for cell_line: CellLine in cells.get_children():
		for cell_button_2d: CellButton2D in cell_line.get_children():
			cell_button_2d.button_clicked.connect(_on_button_clicked.bind(cell_button_2d))
			buttons.append(cell_button_2d)

	_on_reset_button_pressed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
