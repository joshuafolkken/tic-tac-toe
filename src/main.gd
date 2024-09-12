class_name Main
extends Node

@onready var _game_manager: GameManager = $GameManager
@onready var _ui_manager: UIManager = $UIManager
@onready var _input_handler: InputHandler = $InputHandler
@onready var _click_sound: ClickSound = $ClickSound


func reset() -> void:
	_game_manager.reset()
	_ui_manager.reset()
	_click_sound.play_reset()


func _ready() -> void:
	_input_handler.cell_clicked.connect(_on_cell_clicked)
	_input_handler.reset_requested.connect(_on_reset_requested)
	_game_manager.game_ended.connect(_on_game_ended)
	_game_manager.player_changed.connect(_on_player_changed)

	reset()


func disappear_cells(positions: Array[BoardPosition]) -> void:
	if positions[0].is_valid():
		_ui_manager.clear_cell(positions[0])
	if positions[1].is_valid():
		_ui_manager.fade_cell(positions[1])


func _on_cell_clicked(position: BoardPosition) -> void:
	var cell_status := CellStatus.from_game_player(_game_manager.get_current_player())
	_ui_manager.update_cell(position, cell_status)
	var disappear_positions := _game_manager.make_move(position)
	disappear_cells(disappear_positions)


func _on_reset_requested() -> void:
	reset()


func _on_game_ended(result: String) -> void:
	_ui_manager.end_game()
	_ui_manager.update_status_label(result)
	_click_sound.play_game_end()


func _on_player_changed(_player: GamePlayer) -> void:
	pass
