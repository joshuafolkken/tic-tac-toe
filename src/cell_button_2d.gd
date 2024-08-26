class_name CellButton2D
extends Node2D

signal button_clicked(board_position: BoardPosition)

@export var button_index := 0

@onready var cell_button: Button = $CellButton
@onready var click_sound: ClickSound = $ClickSound
@onready var cross: Node2D = $Cross
@onready var circle: Node2D = $Circle


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cell_button.pressed.connect(_on_button_pressed)
	reset()


func set_button_visibility(value: bool) -> void:
	cell_button.visible = value


func _show_mark(cell_status: CellStatus) -> void:
	cross.visible = cell_status.is_x()
	circle.visible = cell_status.is_o()
	set_button_visibility(cell_status.is_empty())
	fade(false)


func _on_button_pressed() -> void:
	var cell_line := get_parent() as CellLine
	var line_index := cell_line.line_index
	var board_position := BoardPosition.new(line_index, button_index)

	button_clicked.emit(board_position)


func _process(_delta: float) -> void:
	pass


func update_status(cell_status: CellStatus) -> void:
	_show_mark(cell_status)

	if cell_status.is_x():
		click_sound.play_cross()
	elif cell_status.is_o():
		click_sound.play_circle()


func reset() -> void:
	_show_mark(CellStatus.empty)


func fade(value: bool) -> void:
	modulate.a = 0.5 if value else 1.0
