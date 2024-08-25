@tool
extends Node2D

@export var radius := 58.0
@export var line_width := 22.0
@export var color := Color8(148, 188, 240)


func _draw() -> void:
	draw_arc(Vector2.ZERO, radius, 0, TAU, 360, color, line_width, true)
