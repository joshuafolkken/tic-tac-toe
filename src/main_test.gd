# gdlint: disable=private-method-call
# GdUnit generated TestSuite
class_name MainTest
extends GdUnitTestSuite

const _SCENE_PATH := "res://scenes/main.tscn"

var _scene_runner: GdUnitSceneRunner
var _scene: Main

@warning_ignore("unused_parameter")


func before_test() -> void:
	_scene_runner = scene_runner(_SCENE_PATH)
	assert_that(_scene_runner).is_not_null()

	_scene = _scene_runner.scene()
	assert_that(_scene).is_not_null()


func is_ready() -> void:
	assert_object(_scene._board).is_not_null()
	assert_object(_scene._position_history).is_not_null()
	assert_object(_scene._current_player).is_not_null()

	# is_reset_buttons
	assert_bool(_scene._status_label.visible).is_false()


func test_ready() -> void:
	is_ready()

	# if _scene != null:
	# 	assert_bool(_scene.test).is_null()
	#assert_that(_scene._board).is_null()
	#assert_that(_scene._position_history).is_not_null()
	#assert_that(_scene._current_player).is_not_null()
#
#assert_bool(_scene._board.get_game_status().is_playing()).is_true()
#assert_bool(_scene.status_label.visible).is_false()
