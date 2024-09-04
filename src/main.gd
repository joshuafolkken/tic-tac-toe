class_name Main
extends Node

var _cell_collection := CellCcollection.new()

var _board: Board
var _position_history: PositionHistory
var _current_player: GamePlayer

@onready var _cells := $Cells
@onready var _reset_button: Button = $ResetButton
@onready var _click_sound: ClickSound = $ClickSound
@onready var _status_label: Label = $StatusLabel


func reset() -> void:
	_board = Board.new()
	_position_history = PositionHistory.new()
	_current_player = GamePlayer.new()

	_cell_collection.reset_all()
	_status_label.visible = false

	_click_sound.play_reset()


func _update_result_label(text: String) -> void:
	_status_label.text = text
	_status_label.visible = true


func _check_game_end() -> bool:
	var game_status := _board.get_game_status()

	if game_status.is_playing():
		return false

	var result_text := game_status.get_result_text()
	_update_result_label(result_text)

	_cell_collection.end_game()
	_click_sound.play_game_end()

	return true


func _clear_cell(board_position: BoardPosition) -> void:
	if not board_position.is_valid():
		return

	_cell_collection.clear(board_position)
	_board.add_empty(board_position)


func _fade_cell(board_position: BoardPosition) -> void:
	if not board_position.is_valid():
		return

	_cell_collection.fade(board_position)


func _disappear_cells(board_positions: Array[BoardPosition]) -> void:
	_clear_cell(board_positions[0])
	_fade_cell(board_positions[1])


func _on_button_clicked(board_position: BoardPosition, cell: Cell) -> void:
	var cell_status := CellStatus.from_game_player(_current_player)
	_board.add(board_position, cell_status)
	cell.update_status(cell_status)

	var disappear_positions := _position_history.append(board_position)
	_disappear_cells(disappear_positions)

	if not _check_game_end():
		_current_player = _current_player.next()


func _on_reset_button_pressed() -> void:
	reset()


func _ready() -> void:
	_reset_button.pressed.connect(_on_reset_button_pressed)

	for cell_line: CellLine in _cells.get_children():
		for cell: Cell in cell_line.get_children():
			cell.button_clicked.connect(_on_button_clicked.bind(cell))

			var board_position := BoardPosition.new(cell_line.get_index(), cell.get_index())
			_cell_collection.add(board_position, cell)

	reset()
