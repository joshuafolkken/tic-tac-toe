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


func test_button_enabled() -> void:
	assert_not_yet_implemented()


func test_button_disabled() -> void:
	assert_not_yet_implemented()


func test_mark_fade() -> void:
	assert_not_yet_implemented()


func test_mark_disappear() -> void:
	assert_not_yet_implemented()


func test_x_wins() -> void:
	assert_not_yet_implemented()


func test_o_wins() -> void:
	assert_not_yet_implemented()
