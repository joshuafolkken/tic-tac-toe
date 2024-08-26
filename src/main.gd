extends Node

var _buttons := Buttons.new()

var _board: Board
var _position_history: PositionHistory
var _current_player: GamePlayer

@onready var cells := $Cells
@onready var reset_button: Button = $ResetButton
@onready var click_sound: ClickSound = $ClickSound
@onready var status_label: Label = $StatusLabel


func reset() -> void:
	_board = Board.new()
	_position_history = PositionHistory.new()
	_current_player = GamePlayer.new()

	_buttons.reset_all()
	status_label.visible = false

	click_sound.play_reset()


func _update_result_label(text: String) -> void:
	status_label.text = text
	status_label.visible = true


func _check_game_end() -> bool:
	var game_status := _board.get_game_status()

	if game_status.is_playing():
		return false

	var result_text := game_status.get_result_text()
	_update_result_label(result_text)

	_buttons.end_game()
	click_sound.play_game_end()

	return true


func _clear_cell(board_position: BoardPosition) -> void:
	if board_position.is_invalid():
		return

	_buttons.clear(board_position)
	_board.set_empty(board_position)


func _fade_cell(board_position: BoardPosition) -> void:
	if board_position.is_invalid():
		return

	_buttons.fade(board_position)


func _disappear_cells(board_positions: Array[BoardPosition]) -> void:
	_clear_cell(board_positions[0])
	_fade_cell(board_positions[1])


func _on_button_clicked(board_position: BoardPosition, cell_button_2d: CellButton2D) -> void:
	var cell_status := CellStatus.from_game_player(_current_player)
	_board.set_value(board_position, cell_status)
	cell_button_2d.update_status(cell_status)

	var disappear_positions := _position_history.add(board_position)
	_disappear_cells(disappear_positions)

	if _check_game_end():
		return

	_current_player = _current_player.next()


func _on_reset_button_pressed() -> void:
	reset()


func _ready() -> void:
	reset_button.pressed.connect(_on_reset_button_pressed)

	for cell_line: CellLine in cells.get_children():
		for cell_button_2d: CellButton2D in cell_line.get_children():
			cell_button_2d.button_clicked.connect(_on_button_clicked.bind(cell_button_2d))
			_buttons.append(cell_button_2d)

	reset()
