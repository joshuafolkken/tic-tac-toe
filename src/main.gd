extends Node

var board := [
	[0, 0, 0],
	[0, 0, 0],
	[0, 0, 0],
]

var current_player_id := 0

@onready var cells := $Cells
@onready var reset_button := $ResetButton


func update_board(row: int, col: int, player_id: int) -> void:
	board[row][col] = player_id


func get_board(row: int, col: int) -> int:
	return board[row][col]


func reset_board() -> void:
	for row in range(3):
		for col in range(3):
			board[row][col] = 0


func _on_button_clicked(row_index: int, col_index: int, cell_button_2d: CellButton2D) -> void:
	# print("button pressed: row: %d, col: %d" % [row_index, col_index])

	var status := current_player_id + 1
	update_board(row_index, col_index, status)
	cell_button_2d.update_status(status)

	current_player_id = (current_player_id + 1) % 2

	# print(board)


func _on_reset_button_pressed():
	reset_board()

	for cell_line: CellLine in cells.get_children():
		for cell_button_2d: CellButton2D in cell_line.get_children():
			cell_button_2d.update_status(0)

	current_player_id = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_button.pressed.connect(_on_reset_button_pressed)

	for cell_line: CellLine in cells.get_children():
		for cell_button_2d: CellButton2D in cell_line.get_children():
			cell_button_2d.button_clicked.connect(_on_button_clicked.bind(cell_button_2d))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
