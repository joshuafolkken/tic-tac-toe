class_name ClickSound2
extends AudioStreamPlayer

const AUDIO_STREAM: AudioStream = preload("res://assets/sounds/tic_tac_toe_sound.wav")
const AUDIO_STREAM_CROSS: AudioStream = preload("res://assets/sounds/cross.wav")
const AUDIO_STREAM_CIRCLE: AudioStream = preload("res://assets/sounds/circle.wav")
const AUDIO_STREAM_RESET: AudioStream = preload("res://assets/sounds/reset.wav")
const AUDIO_STREAM_END: AudioStream = preload("res://assets/sounds/end.wav")


func _ready() -> void:
	AudioServer.register_stream_as_sample(AUDIO_STREAM_CROSS)
	AudioServer.register_stream_as_sample(AUDIO_STREAM_CIRCLE)
	AudioServer.register_stream_as_sample(AUDIO_STREAM_RESET)
	AudioServer.register_stream_as_sample(AUDIO_STREAM_END)

	volume_db = -18


func _process(_delta: float) -> void:
	pass


func _play(audio_stream: AudioStream) -> void:
	stream = audio_stream
	play()


func play_cross() -> void:
	_play(AUDIO_STREAM_CROSS)


func play_circle() -> void:
	_play(AUDIO_STREAM_CIRCLE)


func play_reset() -> void:
	_play(AUDIO_STREAM_RESET)


func play_game_end() -> void:
	_play(AUDIO_STREAM_END)
