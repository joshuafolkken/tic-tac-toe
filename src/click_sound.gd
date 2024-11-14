class_name ClickSound
extends AudioStreamPlayer2D


func _ready() -> void:
	volume_db = -6


func _process(_delta: float) -> void:
	pass


func play_cross() -> void:
	set_pitch_scale(1.20)
	play()


func play_circle() -> void:
	set_pitch_scale(0.60)
	play()


func play_reset() -> void:
	set_pitch_scale(0.30)
	play()


func play_game_end() -> void:
	await get_tree().create_timer(0.5).timeout
	set_pitch_scale(2.00)
	play()

	await get_tree().create_timer(0.1).timeout
	set_pitch_scale(2.20)
	play()

	await get_tree().create_timer(0.1).timeout
	set_pitch_scale(2.40)
	play()
