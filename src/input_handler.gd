class_name InputHandler
extends Node

signal cell_clicked(position: BoardPosition)
signal reset_requested

@onready var _ui_manager: UIManager = $"../UIManager"
@onready var _reset_button: Button = $"../UIManager/ResetButton"


func _initialize_cell_inputs() -> void:
	var cells := _ui_manager.get_cells()

	for cell_line: CellLine in cells.get_children():
		for cell: Cell in cell_line.get_children():
			cell.button_clicked.connect(_on_cell_clicked)


func _ready() -> void:
	_initialize_cell_inputs()
	_reset_button.pressed.connect(_on_reset_button_pressed)


func _on_cell_clicked(board_position: BoardPosition) -> void:
	cell_clicked.emit(board_position)


func _on_reset_button_pressed() -> void:
	reset_requested.emit()
