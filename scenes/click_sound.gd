class_name ClickSound
extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func play_cross() -> void:
	set_pitch_scale(1.20)
	play()


func play_circle() -> void:
	set_pitch_scale(0.60)
	play()
