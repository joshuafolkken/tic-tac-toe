@tool
class_name Circle
extends Node2D

@export var radius := 58.0:
	set(value):
		radius = value
		queue_redraw()

@export var line_width := 22.0:
	set(value):
		line_width = value
		queue_redraw()

@export var color := Color8(148, 188, 240):
	set(value):
		color = value
		queue_redraw()


func _draw() -> void:
	draw_arc(Vector2.ZERO, radius, 0, TAU, 360, color, line_width, true)
