class_name CellButton2D
extends Node2D

@export var button_index := 0

@onready var cell_button: Button = $CellButton

signal button_clicked(row_index: int, col_index: int)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cell_button.pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	var cell_line := get_parent() as CellLine
	var line_index = cell_line.line_index

	#print("cell_line_index: %d, button_index: %d" % [line_index, button_index])
	button_clicked.emit(line_index, button_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
