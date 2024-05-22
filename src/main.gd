extends Node

var board := [
	[0, 0, 0],
	[0, 0, 0],
	[0, 0, 0],
]

@onready var cells := $Cells


func update_board(row: int, col: int, player: int) -> void:
	board[row][col] = player


func get_board(row: int, col: int) -> int:
	return board[row][col]


func reset_board() -> void:
	for row in range(3):
		for col in range(3):
			board[row][col] = 0


func _on_button_clicked(row_index: int, col_index: int) -> void:
	print("button pressed: row: %d, col: %d" % [row_index, col_index])


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for cell_line: CellLine in cells.get_children():
		for cell_button_2d: CellButton2D in cell_line.get_children():
			cell_button_2d.button_clicked.connect(_on_button_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
