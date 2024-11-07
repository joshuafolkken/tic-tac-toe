class_name UIManager
extends Node

var _cell_collection := CellCollection.new()

@onready var _cells := $Cells
@onready var _status_label: Label = $StatusLabel
@onready var _reset_button: Button = $ResetButton
@onready var _version_button: Button = $VersionButton
@onready var _board: Node2D = $Board


func _initialize_cells() -> void:
	for cell_line: CellLine in _cells.get_children():
		for cell: Cell in cell_line.get_children():
			var board_position := BoardPosition.get_instance(
				cell_line.get_index(), cell.get_index()
			)
			_cell_collection.add(board_position, cell)


func _ready() -> void:
	_initialize_cells()
	_version_button.text = "Ver %s" % Settings.version


func update_board(board: Board) -> void:
	for row in BoardPosition.MAX_SIZE:
		for col in BoardPosition.MAX_SIZE:
			var position := BoardPosition.get_instance(row, col)
			var cell_status := board.get_element(position)

			update_cell(position, cell_status)

	var fade_position := board.get_fade_position()

	if fade_position.is_valid():
		_cell_collection.fade(fade_position)


func update_cell(position: BoardPosition, cell_status: CellStatus) -> void:
	var cell := _cell_collection.get_element(position)
	cell.update_status(cell_status)


func update_status_label(text: String) -> void:
	_status_label.text = text
	_status_label.visible = true


func _hide_status_label() -> void:
	_status_label.visible = false


func end_game() -> void:
	_cell_collection.end_game()


func _reset_all_cells() -> void:
	_cell_collection.reset_all()


func reset_board() -> void:
	_board.visible = false
	await get_tree().create_timer(0.1).timeout
	_board.visible = true


func reset() -> void:
	_hide_status_label()
	_reset_all_cells()
	await reset_board()


func get_cells() -> Node:
	return _cells


func get_reset_button() -> Button:
	return _reset_button
