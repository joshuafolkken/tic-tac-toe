class_name CellButton2D
extends Node2D

signal button_clicked(row_index: int, col_index: int)

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


func _show_mark(status: int) -> void:
	var is_cross_visible = status == 1
	var is_circle_visible = status == 2

	cross.visible = is_cross_visible
	circle.visible = is_circle_visible

	set_button_visibility(status == 0)
	fade(false)


func _on_button_pressed() -> void:
	var cell_line := get_parent() as CellLine
	var line_index = cell_line.line_index

	#print("cell_line_index: %d, button_index: %d" % [line_index, button_index])
	button_clicked.emit(line_index, button_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func update_status(status: int) -> void:
	_show_mark(status)

	if status == 1:
		click_sound.play_cross()
	elif status == 2:
		click_sound.play_circle()


func reset() -> void:
	_show_mark(0)


func fade(value: bool) -> void:
	modulate.a = 0.5 if value else 1.0
