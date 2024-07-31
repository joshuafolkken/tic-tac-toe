extends Node

enum GameStatus {
	DRAW = -1,
	PLAYING = 0,
	X_WIN = 1,
	Y_WIN = 2,
}

const EMPTY := 0

var board := [
	[EMPTY, EMPTY, EMPTY],
	[EMPTY, EMPTY, EMPTY],
	[EMPTY, EMPTY, EMPTY],
]

var current_player_id := 0

@onready var cells := $Cells
@onready var reset_button := $ResetButton
@onready var click_sound: ClickSound = $ClickSound
@onready var status_label := $StatusLabel


func _update_board(row: int, col: int, player_id: int) -> void:
	board[row][col] = player_id


func _get_board(row: int, col: int) -> int:
	return board[row][col]


func _reset_board() -> void:
	for row in range(3):
		for col in range(3):
			board[row][col] = EMPTY


func _get_game_status() -> int:
	for row in board:
		if row[0] != EMPTY and row[0] == row[1] and row[1] == row[2]:
			return row[0]

	for col in range(3):
		if (
			board[0][col] != EMPTY
			and board[0][col] == board[1][col]
			and board[1][col] == board[2][col]
		):
			return board[0][col]

	if board[0][0] != EMPTY and board[0][0] == board[1][1] and board[1][1] == board[2][2]:
		return board[0][0]

	if board[0][2] != EMPTY and board[0][2] == board[1][1] and board[1][1] == board[2][0]:
		return board[0][2]

	var is_full = true

	for row in board:
		if not is_full:
			break

		for cell in row:
			if cell == EMPTY:
				is_full = false
				break

	if is_full:
		return -1

	return 0


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


func _iterate_cells(callback: Callable) -> void:
	for cell_line: CellLine in cells.get_children():
		for cell_button_2d: CellButton2D in cell_line.get_children():
			callback.call(cell_button_2d)


func _check_game_end() -> void:
	var game_status := _get_game_status()

	if game_status == GameStatus.PLAYING:
		return

	var label_text := _get_result_text(game_status)
	_update_status_label(label_text)

	_iterate_cells(func(cell_button_2d: CellButton2D): cell_button_2d.set_button_visibility(false))
	click_sound.play_game_end()


func _on_button_clicked(row_index: int, col_index: int, cell_button_2d: CellButton2D) -> void:
	# print("button pressed: row: %d, col: %d" % [row_index, col_index])

	var status := current_player_id + 1
	_update_board(row_index, col_index, status)
	cell_button_2d.update_status(status)

	current_player_id = (current_player_id + 1) % 2

	_check_game_end()


func _on_reset_button_pressed():
	_reset_board()

	current_player_id = 0
	status_label.visible = false
	_iterate_cells(func(cell_button_2d: CellButton2D): cell_button_2d.update_status(0))
	_iterate_cells(func(cell_button_2d: CellButton2D): cell_button_2d.set_button_visibility(true))

	click_sound.play_reset()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_button.pressed.connect(_on_reset_button_pressed)

	_iterate_cells(
		func(cell_button_2d: CellButton2D): cell_button_2d.button_clicked.connect(
			_on_button_clicked.bind(cell_button_2d)
		)
	)

	_on_reset_button_pressed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
