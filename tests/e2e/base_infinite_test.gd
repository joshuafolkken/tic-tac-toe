class_name BaseInfiniteTest
extends BaseTest


func before_test() -> void:
	super.before_test()

	_scene._game_manager._is_infinite_enabled = true
	_scene._game_manager._is_ai_player_x_enabled = false
	_scene._game_manager._is_ai_player_o_enabled = false
