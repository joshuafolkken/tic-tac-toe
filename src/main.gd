class_name Main
extends Node

const AI_DELAY_SEC_DEFAULT = 0.8
const AI_DELAY_SEC_MINIMUM = 0.01

var _ai_delay_sec: float

@onready var _game_manager: GameManager = $GameManager
@onready var _ui_manager: UIManager = $UIManager
@onready var _input_handler: InputHandler = $InputHandler
@onready var _click_sound: ClickSound = $ClickSound


func _connect_signals() -> void:
	_game_manager.game_ended.connect(_on_game_ended)
	_game_manager.player_changed.connect(_on_player_changed)
	_game_manager.board_updated.connect(_on_board_updated)
	_game_manager.ai_reset.connect(_on_ai_reset)
	_input_handler.cell_clicked.connect(_on_cell_clicked)
	_input_handler.reset_requested.connect(_on_reset)


func _on_ai_reset() -> void:
	await get_tree().create_timer(_ai_delay_sec).timeout

	if _ai_delay_sec >= AI_DELAY_SEC_MINIMUM:
		_ai_delay_sec = _ai_delay_sec * 0.8

	print(_ai_delay_sec)

	_game_manager.reset(_ai_delay_sec)
	await _ui_manager.reset()


func _on_reset() -> void:
	_ai_delay_sec = AI_DELAY_SEC_DEFAULT

	_game_manager.reset(_ai_delay_sec)
	await _ui_manager.reset()
	_click_sound.play_reset()


func _ready() -> void:
	_connect_signals()
	_on_reset()


func _on_board_updated(board: Board, current_player: GamePlayer) -> void:
	_ui_manager.update_board(board)

	if current_player.is_x():
		_click_sound.play_cross()
	elif current_player.is_o():
		_click_sound.play_circle()


func _on_cell_clicked(position: BoardPosition) -> void:
	if not _game_manager.is_ai_player():
		_game_manager.make_move(position)


func _on_game_ended(result: String) -> void:
	_ui_manager.end_game()
	_ui_manager.update_status_label(result)
	_click_sound.play_game_end()


func _on_player_changed(_player: GamePlayer) -> void:
	pass
