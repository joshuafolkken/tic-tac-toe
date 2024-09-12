class_name BaseTest
extends GdUnitTestSuite

const _SCENE_PATH := "res://scenes/main.tscn"

var _scene_runner: GdUnitSceneRunner
var _scene: Main


func before_test() -> void:
	_scene_runner = scene_runner(_SCENE_PATH)
	assert_that(_scene_runner).is_not_null()

	_scene = _scene_runner.scene()
	assert_that(_scene).is_not_null()


func is_buttons_enabled() -> void:
	for row_index in range(3):
		for col_index in range(3):
			var board_position := BoardPosition.new(row_index, col_index)
			var cell := _scene._ui_manager._cell_collection.get_element(board_position)
			var cell_button := cell._cell_button
			var cell_button_visible := cell_button.visible
			var cross_visible := cell._cross.visible
			var circle_visible := cell._circle.visible

			assert_bool(cell_button_visible).is_true()
			assert_bool(cross_visible).is_false()
			assert_bool(circle_visible).is_false()
