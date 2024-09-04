# gdlint: disable=private-method-call
# GdUnit generated TestSuite
class_name GameplayTest
extends GdUnitTestSuite

const _SCENE_PATH := "res://scenes/main.tscn"

var _scene_runner: GdUnitSceneRunner
var _scene: Main


func before_test() -> void:
	_scene_runner = scene_runner(_SCENE_PATH)
	assert_that(_scene_runner).is_not_null()

	_scene = _scene_runner.scene()
	assert_that(_scene).is_not_null()

	# その他のセルの状態を確認
	for row in range(3):
		for col in range(3):
			if (row != 1 or col != 1) and (row != 0 or col != 0) and (row != 2 or col != 2):
				var other_position := BoardPosition.new(row, col)
				var other_cell := _scene._cell_collection.get_element(other_position)
				assert_bool(other_cell._cell_button.visible).is_true()


func test_x_wins() -> void:
	var positions := [
		BoardPosition.new(0, 0),  # X
		BoardPosition.new(1, 1),  # O
		BoardPosition.new(0, 1),  # X
		BoardPosition.new(2, 2),  # O
		BoardPosition.new(0, 2),  # X
	]

	for position: BoardPosition in positions:
		var cell := _scene._cell_collection.get_element(position)
		cell._cell_button.emit_signal("pressed")

	assert_bool(_scene._status_label.visible).is_true()
	assert_str(_scene._status_label.text).is_equal("X Wins!")


func test_o_wins() -> void:
	var positions := [
		BoardPosition.new(0, 0),  # X
		BoardPosition.new(0, 1),  # O
		BoardPosition.new(1, 0),  # X
		BoardPosition.new(1, 1),  # O
		BoardPosition.new(2, 2),  # X
		BoardPosition.new(2, 1),  # O
	]

	for position: BoardPosition in positions:
		var cell := _scene._cell_collection.get_element(position)
		cell._cell_button.emit_signal("pressed")

	assert_bool(_scene._status_label.visible).is_true()
	assert_str(_scene._status_label.text).is_equal("O Wins!")


func test_draw() -> void:
	assert_not_yet_implemented()

	#var positions := [
	#BoardPosition.new(0, 0),  # X
	#BoardPosition.new(1, 1),  # O
	#BoardPosition.new(0, 2),  # X
	#BoardPosition.new(0, 1),  # O
	#BoardPosition.new(2, 0),  # X
	#BoardPosition.new(1, 0),  # O
	#BoardPosition.new(1, 2),  # X
	#BoardPosition.new(2, 1),  # O
	#BoardPosition.new(2, 2),  # X
	#]
#
#for position: BoardPosition in positions:
#var cell := _scene._cell_collection.get_element(position)
#cell._cell_button.emit_signal("pressed")
#
#assert_bool(_scene._status_label.visible).is_true()
#assert_str(_scene._status_label.text).is_equal("Draw!")
