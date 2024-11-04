class_name Main
extends Node

@onready var _game_manager: GameManager = $GameManager
@onready var _ui_manager: UIManager = $UIManager
@onready var _input_handler: InputHandler = $InputHandler
@onready var _click_sound: ClickSound = $ClickSound


func _connect_signals() -> void:
	_game_manager.game_ended.connect(_on_game_ended)
	_game_manager.player_changed.connect(_on_player_changed)
	_game_manager.board_updated.connect(_on_board_updated)
	_input_handler.cell_clicked.connect(_on_cell_clicked)
	_input_handler.reset_requested.connect(reset)


func reset() -> void:
	_game_manager.reset()
	_ui_manager.reset()
	_click_sound.play_reset()


func _ready() -> void:
	_connect_signals()
	reset()


func _on_board_updated(board: Board) -> void:
	_ui_manager.update_board(board)


func _on_cell_clicked(position: BoardPosition) -> void:
	if not _game_manager.is_ai_player():
		_game_manager.make_move(position)


func _on_game_ended(result: String) -> void:
	_ui_manager.end_game()
	_ui_manager.update_status_label(result)
	_click_sound.play_game_end()


func _on_player_changed(_player: GamePlayer) -> void:
	pass
