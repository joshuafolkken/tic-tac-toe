@tool
extends Node2D

@export var radius := 65.0
@export var line_width := 15.0
@export var color := Color8(148, 188, 240)


func _draw() -> void:
	draw_arc(Vector2.ZERO, radius, 0, TAU, 360, color, line_width, true)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
