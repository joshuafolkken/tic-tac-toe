class_name InputHandler
extends Node

signal cell_clicked(position: BoardPosition)
signal reset_requested

@onready var _ui_manager: UIManager = $"../UIManager"
@onready var _reset_button: Button = $"../UIManager/ResetButton"
@onready var _version_button: Button = $"../UIManager/VersionButton"


func _initialize_cell_inputs() -> void:
	var cells := _ui_manager.get_cells()

	for cell_line: CellLine in cells.get_children():
		for cell: Cell in cell_line.get_children():
			cell.button_clicked.connect(_on_cell_clicked)


func _ready() -> void:
	_initialize_cell_inputs()
	_reset_button.pressed.connect(_on_reset_button_pressed)
	_version_button.pressed.connect(_on_version_button_pressed)


func _on_cell_clicked(board_position: BoardPosition) -> void:
	cell_clicked.emit(board_position)


func _on_reset_button_pressed() -> void:
	reset_requested.emit()


func _on_version_button_pressed() -> void:
	OS.shell_open(Constants.RELEASE_URL)
