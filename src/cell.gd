class_name Cell
extends Node2D

signal button_clicked(board_position: BoardPosition)

@export var button_index := 0

var button_visible: bool:
	get:
		return _cell_button.visible
	set(value):
		_cell_button.visible = value

@onready var _cell_button: Button = $CellButton
@onready var _click_sound: ClickSound = $ClickSound
@onready var _cross: Node2D = $Cross
@onready var _circle: Node2D = $Circle


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_cell_button.pressed.connect(_on_button_pressed)
	reset()


func set_button_visibility(value: bool) -> void:
	_cell_button.visible = value


func is_button_visible() -> bool:
	return _cell_button.visible


func _show_mark(cell_status: CellStatus) -> void:
	_cross.visible = cell_status.is_x()
	_circle.visible = cell_status.is_o()
	_cell_button.visible = cell_status.is_empty()
	fade(false)


func _on_button_pressed() -> void:
	var cell_line: CellLine = get_parent()
	var line_index := cell_line.line_index
	var board_position := BoardPosition.new(line_index, button_index)

	button_clicked.emit(board_position)


func _process(_delta: float) -> void:
	pass


func update_status(cell_status: CellStatus) -> void:
	_show_mark(cell_status)

	if cell_status.is_x():
		_click_sound.play_cross()
	elif cell_status.is_o():
		_click_sound.play_circle()


func reset() -> void:
	_show_mark(CellStatus.empty)


func fade(value: bool) -> void:
	modulate.a = 0.5 if value else 1.0
